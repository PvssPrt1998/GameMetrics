import SwiftUI
import Combine

struct LoadingViewReviewer: View {
    
    @ObservedObject var viewModel: LoadingViewModel
    
    var body: some View {
        ZStack {
            Image(ImageTitles.LoadingLogoReviewer.rawValue)
                .resizable()
                .scaledToFit()
                .frame(height: 110)
                .padding(.bottom, 55)
            ProgressViewCustom(value: $viewModel.value)
        }
        .ignoresSafeArea()
        .onAppear {
            viewModel.stroke()
        }
    }
}

#Preview {
    LoadingViewReviewer(viewModel: LoadingViewModel(dataManager: DataManager()))
}
