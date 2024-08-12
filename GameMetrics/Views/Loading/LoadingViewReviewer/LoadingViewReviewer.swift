import SwiftUI
import Combine

struct LoadingViewReviewer: View {
    
    @ObservedObject var viewModel: LoadingViewModel
    
    var body: some View {
        ZStack {
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
