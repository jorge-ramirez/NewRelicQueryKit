import Foundation

public enum NewRelicServiceError: Error, LocalizedError {
    case couldNotCreateBaseURL
    case couldNotCreateQueryURL
    case couldNotFindEventsInResponse
    case couldNotParseJSONResponse
    case invalidResponseType
    case invalidStatusCode(Int)

    public var errorDescription: String? {
        switch self {
        case .couldNotCreateBaseURL:
            return "Could not create the base query URL."
        case .couldNotCreateQueryURL:
            return "Could not create the query URL."
        case .couldNotFindEventsInResponse:
            return "Could not find the events element in the response."
        case .couldNotParseJSONResponse:
            return "Could not parse the JSON response."
        case .invalidResponseType:
            return "Invalid response type."
        case let .invalidStatusCode(statusCode):
            return "Invalid status code: \(statusCode)."
        }
    }
}

public class NewRelicService {

    private let accountId: String
    private let queryKey: String
    private let urlSession: URLSession

    public init(accountId: String, queryKey: String, urlSession: URLSession = URLSession(configuration: .default)) {
        self.accountId = accountId
        self.queryKey = queryKey
        self.urlSession = urlSession
    }

    // MARK: Public Methods

    public func decodedEventsForQuery<T: Decodable>(_ query: String) async throws -> [T] {
        let json = try await eventsForQuery(query)
        let jsonData = try JSONSerialization.data(withJSONObject: json)
        let objects = try JSONDecoder().decode([T].self, from: jsonData)

        return objects
    }

    public func eventsForQuery(_ query: String) async throws -> [[String: Any]] {
        let json = try await jsonForQuery(query)

        guard let results = json["results"] as? [[String: Any]],
              let events = results.first?["events"] as? [[String: Any]] else {
            throw NewRelicServiceError.couldNotFindEventsInResponse
        }

        return events
    }

    // MARK: Private Methods

    private func jsonForQuery(_ query: String) async throws -> [String: Any] {
        let request = try urlRequest(for: query)
        let (data, response) = try await urlSession.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NewRelicServiceError.invalidResponseType
        }
        guard (200..<300).contains(httpResponse.statusCode) else {
            throw NewRelicServiceError.invalidStatusCode(httpResponse.statusCode)
        }
        guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            throw NewRelicServiceError.couldNotParseJSONResponse
        }

        return json
    }

    private func url(for query: String) throws -> URL {
        let urlString = String(format: "https://insights-api.newrelic.com/v1/accounts/%@/query", accountId)
        guard var urlComponents = URLComponents(string: urlString) else {
            throw NewRelicServiceError.couldNotCreateBaseURL
        }

        urlComponents.queryItems = [.init(name: "nrql", value: query)]

        guard let url = urlComponents.url else {
            throw NewRelicServiceError.couldNotCreateQueryURL
        }

        return url
    }

    private func urlRequest(for query: String) throws -> URLRequest {
        let url = try url(for: query)
        var request = URLRequest(url: url)

        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(queryKey, forHTTPHeaderField: "X-Query-Key")

        return request
    }

}
