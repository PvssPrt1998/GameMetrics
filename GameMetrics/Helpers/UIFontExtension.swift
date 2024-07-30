import SwiftUI

extension UIFont {
    class func fontWith(size: CGFloat, weight: CGFloat, design: UIFontDescriptor.SystemDesign? = nil) -> UIFont {
        let systemFont = UIFont.systemFont(ofSize: size, weight: .init(weight))
        if let design = design, let descriptor = systemFont.fontDescriptor.withDesign(design) {
            return UIFont(descriptor: descriptor, size: size)
        } else {
            return systemFont
        }
    }
    
    class func fontWith(size: CGFloat, weight: UIFont.Weight, design: UIFontDescriptor.SystemDesign? = nil) -> UIFont {
        let systemFont = UIFont.systemFont(ofSize: size, weight: weight)
        if let design = design, let descriptor = systemFont.fontDescriptor.withDesign(design) {
            return UIFont(descriptor: descriptor, size: size)
        } else {
            return systemFont
        }
    }
}
