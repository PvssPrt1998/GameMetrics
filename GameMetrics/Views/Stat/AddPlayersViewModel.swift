import Foundation

final class AddPlayersViewModel: ObservableObject {
    
    @Published var dataManager: DataManager
    @Published var imageData: Data?
    @Published var text: String = ""
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    func setPlayer() {
        guard let imageData = imageData else { return }
        dataManager.players.append(Player(image: imageData, name: text))
    }
}
