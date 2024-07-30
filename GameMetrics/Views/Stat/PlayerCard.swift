
import SwiftUI

struct PlayerCard: View {
    
    let player: Player
    
    var body: some View {
        VStack(spacing: 10) {
            setImage()
                .resizable()
                .scaledToFit()
                .frame(width: 153, height: 113)
                .background(Color.white)
                .clipShape(.rect(cornerRadius: 12))
            TextCustom(text: player.name, size: 17, weight: .semibold, color: .textMain)
        }
        .padding(10)
        .background(Color.bgSecond)
        .clipShape(.rect(cornerRadius: 12))
    }
    
    func setImage() -> Image {
        guard let image = UIImage(data: player.image) else {
            return Image(systemName: "photo")
        }
        return Image(uiImage: image)
    }
}
