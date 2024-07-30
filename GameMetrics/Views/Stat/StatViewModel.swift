import Foundation
import Combine

final class StatViewModel: ObservableObject {
    
    @Published var dataManager: DataManager
    
    @Published var gameData: GameData

    @Published var showAddPlayersView = false
    @Published var showAddNotesView = false
    @Published var showEditStatSheet = false
    
    var playersCount: Int {
        dataManager.players.count
    }
    
    var players: [Player] {
        dataManager.players
    }
    
    var notesCount: Int {
        dataManager.notes.count
    }
    
    var notes: [Note] {
        dataManager.notes
    }
    
    let infoViewModel: InfoViewModel
    
    private var playersAnyCancellable: AnyCancellable?
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
        
        self.infoViewModel = InfoViewModel(dataManager: dataManager)
        
        playersAnyCancellable = gameData.$players.sink { [weak self] _ in
            self?.objectWillChange.send()
        }
    }
    
    func getNoteBy(index: Int) -> Note {
        dataManager.notes[index]
    }
    
    func makeAddPlayersViewModel() -> AddPlayersViewModel {
        AddPlayersViewModel(dataManager: dataManager)
    }
    
    func makeAddNotesViewModel() -> AddNotesViewModel {
        AddNotesViewModel(dataManager: dataManager)
    }
    
    func makeEditStatViewModel() -> EditStatViewModel {
        EditStatViewModel(dataManager: dataManager)
    }
}
