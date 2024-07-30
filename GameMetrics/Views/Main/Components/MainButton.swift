
import SwiftUI

struct MainButton: View {
    
    let text: String
    let imageTitle: String
    
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                Image(systemName: imageTitle)
                    .resizable()
                    .scaledToFit()
                    .fontCustom(size: 30, weight: .semibold, color: .specialPrimary)
                    .frame(width: 47, height: 47)
                    .frame(maxWidth: .infinity, alignment: .leading)
                TextCustom(text: text, size: 17, weight: .semibold, color: Color.textMain)
            }
            .padding(EdgeInsets(top: 16, leading: 19, bottom: 16, trailing: 19))
            .background(Color.bgSecond)
            
            
        }
        .clipShape(.rect(cornerRadius: 20))
    }
}

#Preview {
    MainButton(text: "123", imageTitle: "car", action: {})
        .padding()
        .background(Color.white)
}

