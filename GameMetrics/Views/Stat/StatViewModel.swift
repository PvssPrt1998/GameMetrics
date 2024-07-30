import Foundation
import Combine

final class StatViewModel: ObservableObject {
    
    @Published var gameData: GameDataBase

    @Published var showAddPlayersView = false
    @Published var showAddNotesView = false
    @Published var showEditStatSheet = false
    
    var playersCount: Int {
        gameData.players.count
    }
    
    var players: [Player] {
        gameData.players
    }
    
    var notesCount: Int {
        gameData.notes.count
    }
    
    var notes: [Note] {
        gameData.notes
    }
    
    let infoViewModel: InfoViewModel
    
    private var playersAnyCancellable: AnyCancellable?
    
    init(gameData: GameDataBase) {
        self.gameData = gameData
        
        self.infoViewModel = InfoViewModel(gameData: gameData)
        
        playersAnyCancellable = gameData.$players.sink { [weak self] _ in
            self?.objectWillChange.send()
        }
    }
    
    func getNoteBy(index: Int) -> Note {
        gameData.notes[index]
    }
    
    func makeAddPlayersViewModel() -> AddPlayersViewModel {
        AddPlayersViewModel(gameData: gameData)
    }
    
    func makeAddNotesViewModel() -> AddNotesViewModel {
        AddNotesViewModel(gameData: gameData)
    }
    
    func makeEditStatViewModel() -> EditStatViewModel {
        EditStatViewModel(gameData: gameData)
    }
}
