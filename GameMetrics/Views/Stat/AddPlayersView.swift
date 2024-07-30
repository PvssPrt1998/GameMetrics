import SwiftUI

struct AddPlayersView: View {
    
    @ObservedObject var viewModel: AddPlayersViewModel
    
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            GrabberView()
                .padding(5)
            TextCustom(text: "AddPlayers", size: 17, weight: .semibold, color: .black)
                .padding(EdgeInsets(top: 11, leading: 0, bottom: 41, trailing: 0))
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
    
    private func horizontalPadding() -> CGFloat {
        UIDevice.current.userInterfaceIdiom == .pad ? 36 : 16
    }
    
    private func buttonDisabled() -> Bool {
        (viewModel.text != "" && viewModel.imageData != nil) ? false : true
    }
}

struct AddPlayersView_Preview: PreviewProvider {
    static var previews: some View {
        AddPlayersView(viewModel: AddPlayersViewModel(gameData: DataManager().dotaData), action: {})
            .background(Color.white)
    }
}
