import Foundation
import Combine

final class LoadingViewModel: ObservableObject {
    
    @Published var dataManager: DataManager
    
    let loadedForCoordinator = PassthroughSubject<Bool, Never>()
    
    private var loadedCancellable: AnyCancellable?
    
    @Published var loaded = false
    
    @Published var value: Double = 0
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
        loadedCancellable = dataManager.$dataLoaded.sink { [weak self] _ in
            self?.loaded = true
            self?.loadIfneeded()
        }
        loaded = false
        dataManager.loadLocalData()
    }
    
    func stroke() {
        if value < 1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.02) {
                self.value += 0.02
                self.stroke()
            }
        } else {
            loadIfneeded()
        }
    }
    
    private func loadIfneeded() {
        if value >= 1 && loaded {
            loadedForCoordinator.send(true)
        }
    }
}
