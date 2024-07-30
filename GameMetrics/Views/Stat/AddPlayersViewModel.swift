import Foundation

final class AddPlayersViewModel: ObservableObject {
    
    @Published var gameData: GameDataBase
    @Published var imageData: Data?
    @Published var text: String = ""
    
    init(gameData: GameDataBase) {
        self.gameData = gameData
    }
    
    func setPlayer() {
        guard let imageData = imageData else { return }
        gameData.players.append(Player(image: imageData, name: text))
    }
}
