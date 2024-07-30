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
        .background(Color.specialPrimary.opacity(disabled ? 0.3 : 1))
        .clipShape(.rect(cornerRadius: 50))
    }
}

#Preview {
    PrimaryButton(title: "Edit", disabled: true, action: {})
        .frame(width: 160, height: 45)
}
