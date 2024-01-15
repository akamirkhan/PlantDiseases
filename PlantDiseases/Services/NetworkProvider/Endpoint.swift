import UIKit

struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem]
}

extension Endpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "shans.d2.i-partner.ru"
        components.path = "/api/ppp" + "/\(path)/"
        components.queryItems = queryItems
        
        return components.url
    }
}
