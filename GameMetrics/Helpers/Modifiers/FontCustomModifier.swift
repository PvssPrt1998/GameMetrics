import SwiftUI

struct FontCustomModifier: ViewModifier {
    let size: CGFloat
    let weight: UIFont.Weight
    let color: Color?
    var design: UIFontDescriptor.SystemDesign? = nil
    
    func body(content: Content) -> some View {
        content
            .font(Font(UIFont.fontWith(size: size, weight: weight, design: design)))
            .foregroundColorCustom(color != nil ? color! : Color.black)
    }
}

extension View {
    func fontCustom(size: CGFloat, weight: UIFont.Weight, color: Color? = nil, design: UIFontDescriptor.SystemDesign? = nil) -> some View {
        modifier(FontCustomModifier(size: size, weight: weight, color: color, design: design))
    }
}
