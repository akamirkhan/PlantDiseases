import SwiftUI

struct PesticideDetailScreen: View {
    let pesticide: Pesticide
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 24) {
            NavigationBar {
                presentationMode.wrappedValue.dismiss()
            }
            
            contentView
        }
    }
    
    private var contentView: some View {
        VStack(spacing: 16) {
            PesticideImageView(pesticide: pesticide)
            PesticideDescriptionView(pesticide: pesticide)
            WhereBuyButton(title: "Где купить") {}
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.horizontal)
    }
}

#Preview {
    PesticideDetailScreen(pesticide: .example)
}
