import SwiftUI

struct WhereBuyButton: View {
    let title: String
    let action: EmptyBlock
    
    var body: some View {
        Button(action: action) {
            contentView
        }
    }
    
    private var contentView: some View {
        HStack(spacing: 4) {
            Image(.pinIcon)
            Text(title.uppercased())
                .font(Font.system(size: 12, weight: .semibold))
                .foregroundColor(.black)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 36)
        .background(Color.white)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.overly)
        )
    }
}

#Preview {
    WhereBuyButton(title: "Где купить", action: {})
}
