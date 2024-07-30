import SwiftUI

struct RoundedCorner: Shape {
    let radius: CGFloat
    let corners: UIRectCorner

    init(radius: CGFloat = .infinity, corners: UIRectCorner = .allCorners) {
        self.radius = radius
        self.corners = corners
    }

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
    
    func cornerRadius(_ radius: CGFloat, firstOrLastElement isFirst: Bool?) -> some View {
        guard let isFirst = isFirst else { return cornerRadius(radius, corners: [.allCorners]) }
        if isFirst {
            return cornerRadius(radius, corners: [.topLeft, .topRight])
        } else {
            return cornerRadius(radius, corners: [.bottomLeft, .bottomRight])
        }
    }
}

