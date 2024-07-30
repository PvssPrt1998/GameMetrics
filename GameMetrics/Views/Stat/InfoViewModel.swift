import Foundation
import Combine

final class InfoViewModel: ObservableObject {
    
    @Published var dataManager: DataManager
    
    var stat: Stat {
        dataManager.stat
    }
    
    private var statAnyCancellable: AnyCancellable?
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
        
        statAnyCancellable = dataManager.$stat.sink { [weak self] _ in
            self?.objectWillChange.send()
        }
    }
    
}
