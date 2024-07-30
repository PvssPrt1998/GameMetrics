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
        .background(Color.onboardingControls)
        .clipShape(.rect(cornerRadius: 8))
    }
}

#Preview {
    NextButton(action: {})
        .frame(width: 160, height: 45)
}
