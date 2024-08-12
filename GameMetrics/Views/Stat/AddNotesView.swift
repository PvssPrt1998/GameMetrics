import SwiftUI

struct AddNotesView: View {
    
    @ObservedObject var viewModel: AddNotesViewModel
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @State var showColorPicker = false
    @Binding var isPortrait: Bool
    let action: () -> Void
    
    @ViewBuilder var contentWrapper: some View {
        if !isPortrait {
            ScrollView {
                content
            }
        } else {
            content
        }
    }
    
    var content: some View {
        VStack(spacing: 0) {
            if isPortrait {
                GrabberView()
                    .padding(5)
            }
            
            ZStack {
                TextCustom(text: "Add Notes", size: 17, weight: .semibold, color: .black)
                    .padding(EdgeInsets(top: 11, leading: 0, bottom: 41, trailing: 0))
                if !isPortrait {
                    Button {
                        action()
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .scaledToFit()
                            .foregroundColorCustom(.black)
                            .frame(width: 24, height: 24)
                    }
                    .padding(EdgeInsets(top: 24, leading: 0, bottom: 0, trailing: 24 + max(safeAreaInsets.trailing, safeAreaInsets.leading)))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                }
            }
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
            .padding(.horizontal, horizontalPadding())
        }
    }
    
    var body: some View {
        contentWrapper
    }
    
    private func horizontalPadding() -> CGFloat {
        UIDevice.current.userInterfaceIdiom == .pad ? 36 + max(safeAreaInsets.leading, safeAreaInsets.trailing) : 16 + max(safeAreaInsets.leading, safeAreaInsets.trailing)
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

struct AddNotesView_Preview: PreviewProvider {
    
    @State static var isPortrait: Bool = true
    
    static var previews: some View {
        AddNotesView(viewModel: AddNotesViewModel(gameData: DataManager().dotaData), isPortrait: $isPortrait, action: {})
            .background(Color.white)
    }
    
   
}
