import Combine
import Foundation

final class PesticideService {
    private let networkProvider: NetworkProvider
    
    init(networkProvider: NetworkProvider = .init()) {
        self.networkProvider = networkProvider
    }
    
    func getPesticides(with offSet: Int) -> AnyPublisher<[PesticideDTO], NetworkError> {
        networkProvider.request(type: [PesticideDTO].self, endpoint: .pesticides(with: offSet))
    }
    
    func getPesticides(for searchTerm: String) -> AnyPublisher<[PesticideDTO], NetworkError> {
        networkProvider.request(type: [PesticideDTO].self, endpoint: .pesticides(for: searchTerm))
    }
}
