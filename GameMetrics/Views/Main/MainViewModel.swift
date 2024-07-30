import Foundation
import Combine

final class MainViewModel: ObservableObject {
    
    @Published var dataManager: DataManager
    
    @Published var showTeamEditSheet: Bool = false
    @Published var showDotaStatSheet: Bool = false
    @Published var showLolStatSheet: Bool = false
    @Published var showSettingsSheet: Bool = false
    
    let teamEditViewModel: TeamEditViewModel
    let dotaStatViewModel: StatViewModel
    let lolStatViewModel: StatViewModel
    
    var screenHeight: CGFloat = 0
    
    private var teamDataCancellable: AnyCancellable?
    
    var team: Team? {
        dataManager.team
    }
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
        self.teamEditViewModel = TeamEditViewModel(dataManager: dataManager)
        self.dotaStatViewModel = StatViewModel(gameData: dataManager.dotaData)
        self.lolStatViewModel = StatViewModel(gameData: dataManager.lolData)
        
        teamDataCancellable = dataManager.$team.sink { [weak self] team in
            self?.objectWillChange.send()
        }
    }
    
    func editButtonPressed() {
        showTeamEditSheet = true
    }
    
    func saveButtonPressed() {
        showTeamEditSheet = false
    }
    
    func dotaStatButtonPressed() {
        showDotaStatSheet = true
    }
    
    func lolStatButtonPressed() {
        showLolStatSheet = true
    }
    
    func settingsButtonPressed() {
        showSettingsSheet = true
    }
}
