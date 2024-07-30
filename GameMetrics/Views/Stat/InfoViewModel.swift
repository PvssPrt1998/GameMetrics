import Foundation
import Combine

final class InfoViewModel: ObservableObject {
    
    @Published var gameData: GameDataBase
    
    var stat: Stat {
        gameData.stat
    }
    
    private var statAnyCancellable: AnyCancellable?
    
    init(gameData: GameDataBase) {
        self.gameData = gameData
        
        statAnyCancellable = gameData.$stat.sink { [weak self] _ in
            self?.objectWillChange.send()
        }
    }
}
