import SwiftUI

struct EmptyPlayersView: View {
    
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 8) {
            TextCustom(text: "Players", size: 28, weight: .bold, color: .textMain)
            TextCustom(text: "Your team will be\nrepresented here", size: 15, weight: .regular, color: .textSecond)
            Button {
                action()
            } label: {
                HStack(spacing: 5) {
                    Image(systemName: "plus")
                        .fontCustom(size: 20, weight: .medium, color: .white)
                    TextCustom(text: "Click to add new players", size: 14, weight: .bold)
                }
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                .background(Color.specialPrimary)
                .clipShape(.rect(cornerRadius: 50))
            }
        }
        .padding(.bottom, 30)
    }
}

#Preview {
    EmptyPlayersView() {
        
    }
    .background(Color.white)
}
