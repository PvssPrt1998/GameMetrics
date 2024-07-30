import SwiftUI

struct GrabberView: View {
    var body: some View {
        Color.grabber
            .frame(width: 36, height: 5)
            .clipShape(.rect(cornerRadius: 20))
    }
}

#Preview {
    GrabberView()
        .padding(100)
        .background(Color.bgSecond)
    
}

