import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @Binding var isActive: Bool
    
    var body: some View {
        HStack {
            if isActive {
                TextField(
                    "",
                    text: $text,
                    prompt: Text("Поиск")
                        .foregroundColor(.secondary)
                )
            }
            
            Image(isActive ? .xIcon : .searchIcon)
                .frame(width: 24, height: 24)
                .frame(maxWidth: 20, alignment: .trailing)
                .onTapGesture {
                    isActive.toggle()
                    text = ""
                }
        }
        .frame(height: 40)
        .frame(maxWidth: isActive ? .infinity : 30)
        .foregroundColor(.white)
        .background(Color.navigation)
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
}

#Preview {
    SearchBar(text: .constant(""), isActive: .constant(true))
        .padding()
}
