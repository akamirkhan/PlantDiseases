import SwiftUI

struct PesticideView: View {
    let pesticide: Pesticide
    
    var body: some View {
        contentView
    }
    
    private var contentView: some View {
        VStack(spacing: 12) {
            ImageView(urlString: pesticide.category.image)
                .frame(height: 82)
                .cornerRadius(8)
            
            textView
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(12)
        .frame(height: 296)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: .shadow.opacity(0.15), radius: 2)
    }
    
    private var textView: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(pesticide.name)
                .font(Font.system(size: 12, weight: .semibold))
                .foregroundColor(.black)
            
            Text(pesticide.description)
                .font(Font.system(size: 10, weight: .medium))
                .foregroundColor(.description)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .multilineTextAlignment(.leading)
    }
}

#Preview {
    ScrollView {
        PesticideView(pesticide: .example)
            .padding(.horizontal, 16)
    }
}
