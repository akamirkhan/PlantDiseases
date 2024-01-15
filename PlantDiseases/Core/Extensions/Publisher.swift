import Combine
import Foundation

extension Publisher where Output == (data: Data, response: URLResponse) {
    func assumeHTTP() -> AnyPublisher<(data: Data, response: HTTPURLResponse), NetworkError> {
        tryMap { (data: Data, response: URLResponse) in
            guard let http = response as? HTTPURLResponse else { throw NetworkError.nonHTTPResponse }
            return (data, http)
        }
        .mapError { error in
            guard let networkError = error as? NetworkError else {
                return NetworkError.networkError(error.localizedDescription)
            }
            
            return networkError
        }
        .eraseToAnyPublisher()
    }
}

extension Publisher where Output == (data: Data, response: HTTPURLResponse), Failure == NetworkError {
    func responseData() -> AnyPublisher<Data, NetworkError> {
        tryMap { (data: Data, response: HTTPURLResponse) -> Data in
            switch response.statusCode {
            case 200: return data
            case 400...499:
                throw NetworkError.requestFailed(response.statusCode)
            case 500...599:
                throw NetworkError.serverError(response.statusCode)
            default:
                throw NetworkError.networkError("Unhandled HTTP Response Status code: \(response.statusCode)")
            }
        }
        .mapError { $0 as! NetworkError }
        .eraseToAnyPublisher()
    }
}

extension Publisher where Output == Data, Failure == NetworkError {
    func decoding<Item, Coder>(
        type: Item.Type, decoder: Coder = JSONDecoder()
    ) -> AnyPublisher<Item, NetworkError> where Item: Decodable, Coder: TopLevelDecoder, Self.Output == Coder.Input {
        decode(type: Item.self, decoder: decoder)
            .mapError {
                guard let networkError = $0 as? NetworkError else {
                    let decodingError = $0 as! DecodingError
                    return NetworkError.decodingError(decodingError)
                }
                
                return networkError
            }
            .eraseToAnyPublisher()
    }
}

