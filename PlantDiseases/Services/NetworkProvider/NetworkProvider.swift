import Foundation
import Combine

final class NetworkProvider {
    
    func request<T: Decodable>(type: T.Type, endpoint: Endpoint) -> AnyPublisher<T, NetworkError> {
        guard let url = endpoint.url else {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: URLRequest(url: url))
            .assumeHTTP()
            .responseData()
            .decoding(type: T.self)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
