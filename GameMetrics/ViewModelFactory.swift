import Foundation

final class ViewModelFactory {
    
    let dataManager: DataManager
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    func makeMainViewModel() -> MainViewModel {
        MainViewModel(dataManager: dataManager)
    }
}
