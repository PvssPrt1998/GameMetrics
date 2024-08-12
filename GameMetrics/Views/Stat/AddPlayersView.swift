import SwiftUI

struct AddPlayersView: View {
    
    @ObservedObject var viewModel: AddPlayersViewModel
    
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    @Binding var isPortrait: Bool
    let action: () -> Void
    
    @ViewBuilder var contentWrapper: some View {
        if isPortrait {
            content
        } else {
            ScrollView {
                content
            }
        }
    }
    
    var content: some View {
        VStack(spacing: 0) {
            if isPortrait {
                GrabberView()
                    .padding(5)
            }
            
            ZStack {
                TextCustom(text: "AddPlayers", size: 17, weight: .semibold, color: .black)
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
                ImageView(imageData: $viewModel.imageData)
                    .frame(width: 153, height: 153)
                EditTextField(text: $viewModel.text, label: "Name", placeholder: "Enter")
                PrimaryButton(title: "Add", disabled: buttonDisabled()) {
                    viewModel.setPlayer()
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
    
    private func buttonDisabled() -> Bool {
        (viewModel.text != "" && viewModel.imageData != nil) ? false : true
    }
}

struct AddPlayersView_Preview: PreviewProvider {
    
    @State static var isPortrait: Bool = true
    
    static var previews: some View {
        AddPlayersView(viewModel: AddPlayersViewModel(gameData: DataManager().dotaData), isPortrait: $isPortrait, action: {})
            .background(Color.white)
    }
}
