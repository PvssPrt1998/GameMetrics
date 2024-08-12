import SwiftUI

struct TeamEditView: View {
    
    @ObservedObject var viewModel: TeamEditViewModel
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
                TextCustom(text: "Edit info team", size: 17, weight: .semibold, color: .black)
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
                EditTextField(text: $viewModel.text, label: "Name team", placeholder: "Enter")
                PrimaryButton(title: "Save", disabled: buttonDisabled()) {
                    viewModel.setTeam()
                    action()
                }
            }
            .padding(.horizontal, 20 + max(safeAreaInsets.leading, safeAreaInsets.trailing))
        }
    }
    
    var body: some View {
        contentWrapper
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                            guard let scene = UIApplication.shared.windows.first?.windowScene else { return }
                            self.isPortrait = scene.interfaceOrientation.isPortrait
                        }
    }
    
    private func buttonDisabled() -> Bool {
        (viewModel.text != "" && viewModel.imageData != nil) ? false : true
    }
}

struct TeamEditView_Preview: PreviewProvider {
    
    @State static var isPortrait = true
    
    static var previews: some View {
        TeamEditView(viewModel: TeamEditViewModel(dataManager: DataManager()), isPortrait: $isPortrait,action: {})
            .background(Color.white)
    }
}
