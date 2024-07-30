import SwiftUI

struct EditStatView: View {
    
    @ObservedObject var viewModel: EditStatViewModel
    @StateObject var sheetSizeManager: SheetSizeManager
    @Binding var showSheet: Bool
    
    var body: some View {
        VStack(spacing: 15) {
            GrabberView()
                .padding(.top, 5)
            TextCustom(text: "Edit statistic", size: 15, weight: .bold, color: .textMain)
                .padding(.horizontal, 16)
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
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.white)
        .cornerRadius(10, corners: [.topLeft, .topRight])
        .offset(x: 0, y: sheetSizeManager.topPadding)
        .gesture(
            sheetSizeManager.dragGesture
                .onChanged({value in
                    sheetSizeManager.dragGestureOnChanged(value)
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
    }
    
    private func horizontalPadding() -> CGFloat {
        UIDevice.current.userInterfaceIdiom == .pad ? 36 : 20
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
    
    let defaultPadding: CGFloat = 386
    @Published var topPadding: CGFloat
    
    let screenHeight: CGFloat
    let sheetHeight: CGFloat
    
    let dragGesture: DragGesture
    
    init(screenHeight: CGFloat) {
        self.dragGesture = DragGesture()
        self.screenHeight = screenHeight
        self.sheetHeight = screenHeight - defaultPadding
        self.topPadding = screenHeight
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
