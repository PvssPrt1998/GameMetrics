import SwiftUI
import Combine

struct LoadingViewReviewer: View {
    
    let loaded = PassthroughSubject<Bool, Never>()
    
    @State var value: Double = 0
    
    var body: some View {
        ZStack {
            Image(ImageTitles.LoadingLogoReviewer.rawValue)
                .resizable()
                .scaledToFit()
                .frame(height: 110)
                .padding(.bottom, 55)
            ProgressViewCustom(value: $value)
        }
        .ignoresSafeArea()
        .onAppear {
            stroke()
        }
    }
    
    private func stroke() {
        if value < 1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.02) {
                self.value += 0.02
                self.stroke()
            }
        } else {
            loaded.send(true)
        }
    }
}

#Preview {
    LoadingViewReviewer()
}
