import SwiftUI

struct PesticidesScreen: View {
    @StateObject var viewModel: PesticidesScreenModel
    
    var body: some View {
        contentView
    }
    
    private var contentView: some View {
        NavigationStack {
            VStack(spacing: 0) {
                navigationBarView
                viewModel
                    .viewState
                    .default(content: collectionView) {
                        viewModel.getPesticides(showLoading: true)
                    }
            }
        }
    }
    
    private var collectionView: some View {
        ScrollView {
            LazyVGrid(
                columns: Array(repeating: GridItem(spacing: 15), count: 2),
                spacing: 15
            ) {
                ForEach(viewModel.pesticide) { pesticide in
                    NavigationLink {
                        PesticideDetailScreen(pesticide: pesticide)
                            .navigationBarBackButtonHidden()
                    } label: {
                        PesticideView(pesticide: pesticide)
                    }
                }
                
                Color.clear
                    .frame(height: 44)
                    .onAppear {
                        guard viewModel.viewState.isContent else { return }
                        viewModel.viewState = .content(isPaginating: true)
                        viewModel.getPesticides()
                    }
            }
            .padding(.horizontal, 16)
            .padding(.top, 24)
        }
    }
    
    private var navigationBarView: some View {
        ZStack {
            SearchBar(
                text: $viewModel.searchText,
                isActive: .init(
                    get: { viewModel.viewState.isSearchActive },
                    set: { isActive in
                        if isActive {
                            viewModel.viewState = .search(.info)
                        } else {
                            viewModel.pesticide = viewModel.allPesticide
                            viewModel.viewState = .content(isPaginating: false)
                        }
                    }
                )
            )
            
            Text(viewModel.viewState.isSearchActive ? "" : "Болезни")
                .font(Font.system(size: 17, weight: .semibold))
                .foregroundColor(.white)
        }
        .padding(.horizontal, 16)
        .background(Color.navigation)
    }
}

#Preview {
    PesticidesScreen(viewModel: PesticidesScreenModel())
}
