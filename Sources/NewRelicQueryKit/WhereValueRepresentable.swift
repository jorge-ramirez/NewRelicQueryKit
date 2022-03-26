import Foundation

public protocol WhereValueRepresentable {

    func escapedQueryValue() -> String

}

extension Int: WhereValueRepresentable {

    public func escapedQueryValue() -> String {
        return String(describing: self)
    }

}

extension Double: WhereValueRepresentable {

    public func escapedQueryValue() -> String {
        return String(describing: self)
    }

}

extension Float: WhereValueRepresentable {

    public func escapedQueryValue() -> String {
        return String(describing: self)
    }

}

extension String: WhereValueRepresentable {

    public func escapedQueryValue() -> String {
        return String(format: "'%@'", self)
    }

}

extension Array: WhereValueRepresentable where Element == WhereValueRepresentable {

    /// Returns the escaped values of the elements, joined by a comma and space.
    public func escapedQueryValue() -> String {
        map { $0.escapedQueryValue() }.joined(separator: ", ")
    }

}
