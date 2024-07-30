import SwiftUI

struct NextButton: View {

    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            TextCustom(text: "Next", size: 14, weight: .semibold, color: .white)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .frame(width: 342, height: 48)
        .buttonStyle(NextButtonStyle())
        .clipShape(.rect(cornerRadius: 8))
    }
}

#Preview {
    NextButton(action: {})
        .frame(width: 160, height: 45)
}

struct NextButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(
                configuration.isPressed ? Color.darkShadow : Color.onboardingControls
            )
    }
}
