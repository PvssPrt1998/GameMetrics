import SwiftUI

@main
struct GameMetricsApp: App {
    
    @ObservedObject var appCoordinator: AppCoordinator
    
    init() {
        self.appCoordinator = AppCoordinator(viewModelFactory:
                                                ViewModelFactory(dataManager:
                                                                    DataManager()))
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                Color.white.ignoresSafeArea()
                appCoordinator.build()
            }
            .preferredColorScheme(.dark)
        }
    }
}
