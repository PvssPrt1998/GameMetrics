import Foundation

final class EditStatViewModel: ObservableObject {
    
    let dataManager: DataManager
    
    
    @Published var numberOfMathcesText = ""
    @Published var tournamentPlaceText = ""
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    func setStat() {
        guard let numberOfMatches = Int(numberOfMathcesText), let tournamentPlace = Int(tournamentPlaceText) else { return }
        dataManager.setStat(numberOfMathces: numberOfMatches, tournamentPlace: tournamentPlace)
    }
}
