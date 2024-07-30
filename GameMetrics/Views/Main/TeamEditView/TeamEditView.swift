import SwiftUI

struct TeamEditView: View {
    
    @ObservedObject var viewModel: TeamEditViewModel
    
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            GrabberView()
                .padding(5)
            TextCustom(text: "Edit info team", size: 17, weight: .semibold, color: .black)
                .padding(EdgeInsets(top: 11, leading: 0, bottom: 41, trailing: 0))
            VStack(spacing: 15) {
                ImageView(imageData: $viewModel.imageData)
                    .frame(width: 153, height: 153)
                EditTextField(text: $viewModel.text, label: "Name team", placeholder: "Enter")
                PrimaryButton(title: "Save", disabled: buttonDisabled()) {
                    viewModel.setTeam()
                    action()
                }
            }
            .padding(.horizontal, 20)
        }
    }
    
    private func buttonDisabled() -> Bool {
        (viewModel.text != "" && viewModel.imageData != nil) ? false : true
    }
}

struct TeamEditView_Preview: PreviewProvider {
    static var previews: some View {
        TeamEditView(viewModel: TeamEditViewModel(dataManager: DataManager()),action: {})
            .background(Color.white)
    }
}
