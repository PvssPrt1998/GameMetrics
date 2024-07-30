import Foundation

final class EditStatViewModel: ObservableObject {
    
    let gameData: GameDataBase
    
    @Published var numberOfMathcesText = ""
    @Published var tournamentPlaceText = ""
    
    init(gameData: GameDataBase) {
        self.gameData = gameData
    }
    
    func setStat() {
        guard let numberOfMatches = Int(numberOfMathcesText), let tournamentPlace = Int(tournamentPlaceText) else { return }
        gameData.setStat(numberOfMathces: numberOfMatches, tournamentPlace: tournamentPlace, isDotaType: gameData is DotaData ? true : false )
    }
}
