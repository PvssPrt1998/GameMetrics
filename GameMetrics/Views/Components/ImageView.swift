import SwiftUI

struct ImageView: View {
   
    @Binding var imageData: Data?
    @State var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    var body: some View {
        ZStack {
            Color.bgSecond
            if let image = image {
                ZStack {
                    Color.white
                    image
                        .resizable()
                        .scaledToFit()
                }
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                    .foregroundColorCustom(.specialPrimary)
            }
        }
        .clipShape(.rect(cornerRadius: 20))
        .onTapGesture {
            showingImagePicker = true
        }
        .onChange(of: inputImage) { _ in
            loadImage()
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
                .ignoresSafeArea()
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
        imageData = inputImage.pngData()
    }
}
