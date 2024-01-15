import Foundation

extension Endpoint {
    static func pesticides(for searchTerm: String) -> Self {
        Endpoint(path: "index", queryItems: [URLQueryItem(name: "search", value: searchTerm)])
    }
    
    static func pesticides(with offset: Int) -> Self {
        Endpoint(
            path: "index",
            queryItems: [
                URLQueryItem(name: "offset", value: "\(offset)"),
                URLQueryItem(name: "limit", value: "6")
            ]
        )
    }
}
