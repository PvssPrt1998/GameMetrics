import SwiftUI

struct TeamView: View {
    
    var team: Team?
    var action: () -> Void
    
    var body: some View {
        VStack(spacing: 15) {
            HStack(spacing: 9) {
                ZStack {
                    if team?.logo != nil {
                        setImage()
                            .resizable()
                            .scaledToFit()
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32, height: 32)
                            .foregroundColorCustom(.specialPrimary)
                    }
                }
                .frame(width: 162, height: 162)
                .background(Color.white)
                .clipShape(.rect(cornerRadius: 20))
                
                
                TextCustom(text: setText(), size: 22, weight: .bold, color: Color.textMain)
                    .multilineTextAlignment(.center)
            }
            PrimaryButton(title: "Edit", disabled: false) {
                action()
            }
        }
        .padding(15)
        .background(Color.bgSecond)
        .clipShape(.rect(cornerRadius: 20))
    }
    
    private func setText() -> String {
        team != nil ? team!.title : "Welcome Name Team"
    }
    
    private func setImage() -> Image {
        guard let imageData = team?.logo,
                let image = UIImage(data: imageData) else {
            return Image(systemName: "photo")
        }
        return Image(uiImage: image)
    }
    
}

#Preview {
    TeamView(action: {})
}
