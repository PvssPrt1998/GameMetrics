
import Foundation

final class TeamEditViewModel: ObservableObject {
    
    @Published var dataManager: DataManager
    @Published var imageData: Data?
    @Published var text: String = ""
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    func setTeam() {
        guard let imageData = imageData else { return }
        dataManager.team = Team(logo: imageData, title: text)
    }
}
