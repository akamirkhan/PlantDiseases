import SwiftUI

enum ViewState {
    case error(NetworkError)
    case content(isPaginating: Bool)
    case loading
    case search(SearchState)
    
    enum SearchState {
        case empty
        case info
        case loading
        case content
    }
    
    var isContent: Bool {
        switch self {
        case .content:
            true
        default:
            false
        }
    }
    
    var isSearchActive: Bool {
        switch self {
        case .search:
            true
        default:
            false
        }
    }
    
    @ViewBuilder
    func `default`<Content: View>(content: Content, action: @escaping EmptyBlock) -> some View {
        switch self {
        case .content(let isPaginating):
            content
                .toolbar {
                    if isPaginating {
                        ToolbarItem(placement: .bottomBar) {
                            ProgressView()
                                .frame(height: 44)
                        }
                    }
                }
        case .loading:
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        case  .error(let error):
            VStack {
                ContentUnavailableView(
                    "Error",
                    systemImage: "wifi.exclamationmark",
                    description: Text(error.description)
                )
                
                Button(action: action) {
                    Text("Update")
                }
                .padding()
                .buttonStyle(.bordered)
            }
        case .search(let state):
            searchView(for: state, content: content)
        }
    }
    
    @ViewBuilder
    private func searchView<Content: View>(for state: SearchState, content: Content) -> some View {
        switch state {
        case .content:
            content
        case .empty:
            ContentUnavailableView.search
        case .info:
            ContentUnavailableView(
                "Search",
                systemImage: "magnifyingglass",
                description: Text("Enter your search query")
            )
        case .loading:
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

