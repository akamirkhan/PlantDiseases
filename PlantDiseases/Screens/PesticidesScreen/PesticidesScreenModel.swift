import Foundation
import Combine

final class PesticidesScreenModel: ObservableObject {
    
    @Published var searchText = ""
    @Published var pesticide: [Pesticide] = []
    @Published var viewState: ViewState = .loading

    private let service: PesticideService
    private var currentOffset = Int.zero
    private var cancellables: Set<AnyCancellable> = []
    
    var allPesticide: [Pesticide] = []
    
    init(service: PesticideService = .init()) {
        self.service = service
        
        getPesticides()
        setupSearch()
    }
    
    func getPesticides(showLoading: Bool = false) {
        if showLoading { viewState = .loading }
        
        service.getPesticides(with: currentOffset)
            .sink { [weak self] result in
                if case .failure(let error) = result {
                    self?.viewState = .error(error)
                }
            } receiveValue: { [weak self] response in
                self?.handleResponse(response)
            }
            .store(in: &cancellables)
    }
    
    private func handleResponse(_ response: [PesticideDTO]) {
        let responsePesticides = response.map { $0.pesticideModel }
        allPesticide.append(contentsOf: responsePesticides)
        pesticide.append(contentsOf: responsePesticides)
        currentOffset += response.count
        viewState = .content(isPaginating: false)
    }
    
    private func setupSearch() {
        $searchText
            .dropFirst()
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] searchTerm in
                guard searchTerm.isEmpty == false else {
                    self?.viewState = .search(.info)
                    return
                }
                self?.getPesticides(for: searchTerm)
            }
            .store(in: &cancellables)
    }
    
    private func getPesticides(for searchTerm: String) {
        viewState = .search(.loading)
        
        service.getPesticides(for: searchTerm)
            .sink { [weak self] result in
                if case .failure = result {
                    self?.viewState = .search(.empty)
                }
            } receiveValue: { [weak self] response in
                self?.handleSearchResponse(response)
            }
            .store(in: &cancellables)
    }
    
    private func handleSearchResponse(_ response: [PesticideDTO]) {
        pesticide = response.map { $0.pesticideModel }
        viewState = pesticide.isEmpty ? .search(.empty) : .search(.content)
    }
}
