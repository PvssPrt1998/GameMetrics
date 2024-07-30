import Foundation
import Combine

final class MainViewModel: ObservableObject {
    
    @Published var dataManager: DataManager
    
    @Published var showTeamEditSheet: Bool = false
    @Published var showDotaStatSheet: Bool = false
    @Published var showSettingsSheet: Bool = false
    
    let teamEditViewModel: TeamEditViewModel
    let statViewModel: StatViewModel
    
    var screenHeight: CGFloat = 0
    
    private var teamDataCancellable: AnyCancellable?
    
    var team: Team? {
        dataManager.team
    }
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
        self.teamEditViewModel = TeamEditViewModel(dataManager: dataManager)
        self.statViewModel = StatViewModel(dataManager: dataManager)
        
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
    
    func settingsButtonPressed() {
        showSettingsSheet = true
    }
}
