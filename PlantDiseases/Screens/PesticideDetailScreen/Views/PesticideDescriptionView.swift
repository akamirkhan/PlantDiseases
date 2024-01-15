import SwiftUI

struct PesticideDescriptionView: View {
    let pesticide: Pesticide
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(pesticide.name)
                .font(Font.system(size: 20, weight: .semibold))
            
            Text(pesticide.description)
                .font(Font.system(size: 15))
                .foregroundColor(.description)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    PesticideDescriptionView(pesticide: .example)
}
