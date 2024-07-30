import SwiftUI

final class AddNotesViewModel: ObservableObject {
    
    @Published var dataManager: DataManager
    @Published var nameText: String = ""
    @Published var descriptionText: String = ""
    @Published var tagText: String = ""
    @Published var color: Color = .purple
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    func setNote() {
        guard let colorComponents = UIColor(color).cgColor.components else { return }
        let colorData = colorComponents.map({Int($0)})
        let tagText = tagText.replacingOccurrences(of: "# ", with: "")
        print(colorData)
        dataManager.notes.append(Note(name: nameText,
                                      description: descriptionText,
                                      tag: tagText, 
                                      color: colorData))
    }
}
