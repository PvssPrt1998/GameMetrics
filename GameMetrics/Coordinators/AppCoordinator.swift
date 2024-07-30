import SwiftUI
import Combine

final class AppCoordinator: ObservableObject {
    
    enum Pages {
        case loadingReviewer
        case onboardingReviewer
        case main
    }
    
    @Published var page: Pages = .loadingReviewer
    
    let viewModelFactory: ViewModelFactory
    
    private var dictionaryAnyCancellable = Dictionary<Pages, AnyCancellable>()
    
    init(viewModelFactory: ViewModelFactory) {
        self.viewModelFactory = viewModelFactory
    }
    
    @ViewBuilder func build() -> some View {
        switch page {
        case .loadingReviewer:
            loadingView()
        case .onboardingReviewer:
            onboardingReviewerView()
        case .main:
            MainView(viewModel: viewModelFactory.makeMainViewModel())
        }
    }
    
    private func loadingView() -> some View {
        let view = LoadingViewReviewer()
        bind(view)
        return view
    }
    
    private func bind(_ view: LoadingViewReviewer) {
        dictionaryAnyCancellable[.loadingReviewer] = view.loaded
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.page = .onboardingReviewer
            }
    }
    
    private func onboardingReviewerView() -> some View {
        let view = OnboardingViewReviewer()
        bind(view)
        return view
    }
    
    private func bind(_ view: OnboardingViewReviewer) {
        dictionaryAnyCancellable[.onboardingReviewer] = view.toNext
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.page = .main
            }
    }
}
