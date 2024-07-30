import SwiftUI

struct PrimaryButton: View {

    let title: String
    let disabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            TextCustom(text: title, size: 14, weight: .bold, color: .white)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .disabled(disabled)
        .frame(height: 45)
        .buttonStyle(CustomButton(opacity: disabled ? 0.3 : 1))
        .clipShape(.rect(cornerRadius: 50))
    }
}

struct CustomButton: ButtonStyle {
    
    let opacity: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(
                backgroundForButton(isPressed: configuration.isPressed, opacity: opacity)
            )
    }
    
    @ViewBuilder func backgroundForButton(isPressed: Bool, opacity: CGFloat) -> some View {
        if isPressed {
            ZStack {
                RoundedRectangle(cornerRadius: 50)
                    .fill(Color.specialPrimary)
                    .northWestShadow(radius: 5, offset: 0)
                RoundedRectangle(cornerRadius: 50)
                    .inset(by: 3)
                    .fill(Color.specialPrimary)
                    .southEastShadow(radius: 5, offset: 0)
            }
        } else {
            Color.specialPrimary.opacity(opacity)
        }
    }
}

#Preview {
    PrimaryButton(title: "Edit", disabled: false, action: {})
        .frame(width: 160, height: 45)
        .padding()
        .background(Color.white)
}

extension View {
    func northWestShadow(radius: CGFloat = 16, offset: CGFloat = 6) -> some View {
        self
            .shadow(
                color: .highlightShadow, radius: radius, x: -offset, y: -offset)
            .shadow(
                color: .darkShadow, radius: radius, x: offset, y: offset)
    }

    func southEastShadow(radius: CGFloat = 16, offset: CGFloat = 6) -> some View {
        self
            .shadow(
                color: .darkShadow, radius: radius, x: -offset, y: -offset)
            .shadow(
                color: .highlightShadow, radius: radius, x: offset, y: offset)
      }
}
