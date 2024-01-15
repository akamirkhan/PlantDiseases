import SwiftUI

struct NavigationBar: View {
    
    let action: EmptyBlock
    
    var body: some View {
        HStack {
            Button(action: action) {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundColor(.white)
            }
            .frame(width: 24, height: 24)
            .padding(.horizontal, 16)
        }
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.navigation)
    }
}

#Preview {
    NavigationBar(action: {})
}
