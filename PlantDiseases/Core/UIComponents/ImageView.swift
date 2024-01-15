import SwiftUI
import Kingfisher

struct ImageView: View {
    private let url: URL?
    
    init(urlString: String) {
        self.url = URL(string: urlString)
    }
    
    var body: some View {
        KFImage(url)
            .resizable()
            .placeholder { _ in
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
    }
}

#Preview {
    ImageView(urlString: "")
}
