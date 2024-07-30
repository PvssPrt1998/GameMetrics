import SwiftUI

struct ProgressViewCustom: View {
    
    @Binding var value: Double
    
    var body: some View {
        VStack {
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            HStack(spacing: 8) {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.specialPrimary))
                    .frame(width: 30, height: 30)
                    .scaleEffect(1.5, anchor: .center)
                TextCustom(text: "\(Int(value * 100))%", size: 17, weight: .regular, color: .specialPrimary)
            }
            Spacer()
        }
        .ignoresSafeArea()
    }
}

struct CustomProgressView_Preview: PreviewProvider {
    
    @State static var value: Double = 0.46
    
    static var previews: some View {
        ProgressViewCustom(value: $value)
            .background(Color.black)
    }
}
