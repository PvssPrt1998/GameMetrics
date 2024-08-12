import SwiftUI

struct EditStatView: View {
    
    @ObservedObject var viewModel: EditStatViewModel
    @StateObject var sheetSizeManager: SheetSizeManager
    @Binding var showSheet: Bool
    @Binding var isPortrait: Bool
    
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
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
        VStack(spacing: 15) {
            ZStack {
                VStack(spacing: 15) {
                    if isPortrait {
                        GrabberView()
                            .padding(.top, 5)
                    } else {
                        GrabberView()
                            .padding(.top, 5)
                            .hidden()
                    }
                    TextCustom(text: "Edit statistic", size: 15, weight: .bold, color: .textMain)
                        .padding(.horizontal, 16)
                }
                
                if !isPortrait {
                    Button {
                        sheetSizeManager.dismissSheet()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            showSheet = false
                        }
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
            
           
            
            Divider()
                .padding(.bottom, 5)
            
            EditTextField(text: $viewModel.numberOfMathcesText, label: "Number of matches", placeholder: "Enter")
                .onChange(of: viewModel.numberOfMathcesText, perform: { newValue in
                    numberValidation(newValue)
                })
                .keyboardType(.numberPad)
                .padding(.horizontal, horizontalPadding())
            EditTextField(text: $viewModel.tournamentPlaceText, label: "Tournament place", placeholder: "Enter")
                .onChange(of: viewModel.tournamentPlaceText, perform: { newValue in
                    tournamentValidation(newValue)
                })
                .keyboardType(.numberPad)
                .padding(.horizontal, horizontalPadding())
            PrimaryButton(title: "Save", disabled: buttonDisabled()) {
                viewModel.setStat()
                sheetSizeManager.dismissSheet()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    showSheet = false
                }
            }
            .padding(.horizontal, horizontalPadding())
        }
    }
    
    var body: some View {
        contentWrapper
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.white)
        .cornerRadius(10, corners: [.topLeft, .topRight])
        .offset(x: 0, y: sheetSizeManager.topPadding)
        .gesture(
            sheetSizeManager.dragGesture
                .onChanged({value in
                    if isPortrait {
                        sheetSizeManager.dragGestureOnChanged(value)
                    }
                })
                .onEnded({ value in
                    if sheetSizeManager.dragGestureOnEnded(value) {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            showSheet = false
                        }
                    }
                })
        )
        .onAppear {
            sheetSizeManager.appearance()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                        guard let scene = UIApplication.shared.windows.first?.windowScene else { return }
                        self.isPortrait = scene.interfaceOrientation.isPortrait
                        if isPortrait {
                            sheetSizeManager.defaultPadding = 200
                        } else {
                            sheetSizeManager.defaultPadding = 0
                        }
                    }
    }
    
    private func horizontalPadding() -> CGFloat {
        UIDevice.current.userInterfaceIdiom == .pad ? 36 + max(safeAreaInsets.trailing, safeAreaInsets.leading) : 20 + max(safeAreaInsets.trailing, safeAreaInsets.leading)
    }
    
    private func buttonDisabled() -> Bool {
        (viewModel.numberOfMathcesText != "" && viewModel.tournamentPlaceText != "") ? false : true
    }
    
    private func numberValidation(_ newValue: String) {
        let filtered = newValue.filter { Set("0123456789").contains($0) }

        if filtered != "" {
            viewModel.numberOfMathcesText = filtered
        } else {
            viewModel.numberOfMathcesText = ""
        }
    }
    
    private func tournamentValidation(_ newValue: String) {
        let filtered = newValue.filter { Set("0123456789").contains($0) }

        if filtered != "" {
            viewModel.tournamentPlaceText = filtered
        } else {
            viewModel.tournamentPlaceText = ""
        }
    }
}

class SheetSizeManager: ObservableObject {
    
    @Published var defaultPadding: CGFloat {
        didSet {
            appearance()
        }
    }
    @Published var topPadding: CGFloat
    
    let screenHeight: CGFloat
    var sheetHeight: CGFloat
    
    let dragGesture: DragGesture
    
    init(screenHeight: CGFloat, isPortrait: Bool) {
        self.dragGesture = DragGesture()
        self.defaultPadding = isPortrait ? 200 : 0
        self.screenHeight = screenHeight
        self.topPadding = screenHeight
        self.sheetHeight = screenHeight
        self.sheetHeight = screenHeight - self.defaultPadding
    }
    
    func appearance() {
        withAnimation(.linear(duration: 0.2)) {
            topPadding = defaultPadding
        }
    }
    
    func dragGestureOnChanged(_ value: DragGesture.Value) {
        if value.translation.height > 0 { //drag to bottom
            topPadding = defaultPadding + value.translation.height
        }
    }
    
    func dragGestureOnEnded(_ value: DragGesture.Value) -> Bool {
        let velocity = CGSize(
            width:  value.predictedEndLocation.x - value.location.x,
            height: value.predictedEndLocation.y - value.location.y
        )
        if value.translation.height + velocity.height > (sheetHeight / 2) {
            withAnimation(.linear(duration: 0.1)) {
                topPadding = screenHeight
            }
            return true
        }
        if value.translation.height + velocity.height < (sheetHeight / 2) {
            withAnimation {
                topPadding = defaultPadding
            }
        }
        return false
    }
    
    func dismissSheet() {
        withAnimation(.linear(duration: 0.1)) {
            topPadding = screenHeight
        }
    }
}

extension UIScreen {
    static let screenHeight = UIScreen.current?.bounds.height
}
