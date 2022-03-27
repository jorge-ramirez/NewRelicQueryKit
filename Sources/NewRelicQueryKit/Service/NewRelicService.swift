import Foundation

public enum NewRelicServiceError: Error {
    case couldNotCreateBaseURL
    case couldNotCreateQueryURL
    case couldNotFindResultsInResponse
    case couldNotParseJSONResponse
    case invalidResponseType
    case invalidStatusCode(Int)
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

    public func resultsForQuery(_ query: String) async throws -> [[String: Any]] {
        let json = try await jsonForQuery(query)

        guard let results = json["results"] as? [[String: Any]] else {
            throw NewRelicServiceError.couldNotFindResultsInResponse
        }

        return results
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
