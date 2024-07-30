import SwiftUI

struct ForegroundColorCustomModifier: ViewModifier {
    
    let color: Color
    
    func body(content: Content) -> some View {
        if #available(iOS 15.0, *) {
            content
                .foregroundStyle(color)
        } else {
            content
                .foregroundColor(color)
        }
    }
}

extension View {
    func foregroundColorCustom(_ color: Color) -> some View {
        modifier(ForegroundColorCustomModifier(color: color))
    }
}
