import SwiftUI

struct AddNotesView: View {
    
    @ObservedObject var viewModel: AddNotesViewModel
    @State var showColorPicker = false
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            GrabberView()
                .padding(5)
            TextCustom(text: "Add Notes", size: 17, weight: .semibold, color: .black)
                .padding(EdgeInsets(top: 11, leading: 0, bottom: 41, trailing: 0))
            VStack(spacing: 15) {
                EditTextField(text: $viewModel.nameText, label: "Notes name", placeholder: "Enter")
                EditTextField(text: $viewModel.descriptionText, label: "Description", placeholder: "Enter")
                ZStack {
                    EditTextField(text: $viewModel.tagText, label: "Tag", placeholder: "# Enter", trailingPadding: 56)
                        .onChange(of: viewModel.tagText, perform: { newValue in
                            tagValidation(newValue)
                        })
                    
                    ColorPicker("Colors", selection: $viewModel.color)
                        .labelsHidden()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, 16)
                }
                PrimaryButton(title: "Add", disabled: buttonDisabled()) {
                    viewModel.setNote()
                    action()
                }
            }
            .padding(.horizontal, 20)
        }
    }
    
    private func tagValidation(_ newValue: String) {
        let value = newValue.lowercased()
        let filtered = value.filter { Set("abcdefghijklmnopqrstuvwxyz1234567890").contains($0) }
        if filtered != "" {
            viewModel.tagText = "# " + filtered
        } else {
            viewModel.tagText = ""
        }
    }
    
    private func buttonDisabled() -> Bool {
        if viewModel.nameText != "" && viewModel.descriptionText != "" && viewModel.tagText != "" {
            return false
        } else {
            return true
        }
    }
}

#Preview {
    AddNotesView(viewModel: AddNotesViewModel(dataManager: DataManager()), action: {})
        .background(Color.white)
}
