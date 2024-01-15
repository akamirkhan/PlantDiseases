import SwiftUI

@main
struct PlantDiseasesApp: App {
    
    var body: some Scene {
        WindowGroup {
            PesticidesScreen(viewModel: PesticidesScreenModel())
        }
    }
}
