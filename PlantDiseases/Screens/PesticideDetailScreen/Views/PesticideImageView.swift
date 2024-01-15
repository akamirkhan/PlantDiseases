import SwiftUI

struct PesticideImageView: View {
    let pesticide: Pesticide
    
    var body: some View {
        HStack(alignment: .top) {
            ImageView(urlString: pesticide.category.icon)
                .frame(width: 32, height: 32)
                .cornerRadius(100)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ImageView(urlString: pesticide.image)
                .frame(width: 117, height: 183)
            
            Image(.starIcon)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding()
    }
}

#Preview {
    PesticideImageView(pesticide: .example)
}
