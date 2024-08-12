import SwiftUI
import Combine

struct OnboardingViewReviewer: View {
    
    let toNext = PassthroughSubject<Bool, Never>()
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @State private var selection = 0
    @State private var offset: CGFloat = 0
    @State var isPortrait: Bool
    
    private var backgroundsTitles = [
        ImageTitles.OnboardingBackgroundReviewer1.rawValue,
        ImageTitles.OnboardingBackgroundReviewer2.rawValue,
        ImageTitles.OnboardingBackgroundReviewer3.rawValue
    ]
    
    init() {
        UIScrollView.appearance().bounces = false
        self.isPortrait = UIDevice.current.orientation.isPortrait
    }
    
    var body: some View {
        ZStack {
            ScrollView(.init()) {
                TabView(selection: $selection) {
                    ForEach(backgroundsTitles.indices, id: \.self) { index in
                        if index == 1 {
                            Image(backgroundsTitles[index])
                                .resizable()
                                .overlay(
                                    GeometryReader { proxy -> Color in
                                        let minX = proxy.frame(in: .global).minX
                                        DispatchQueue.main.async {
                                            withAnimation(.default) {
                                                self.offset = -minX
                                            }
                                        }
                                        
                                        return Color.clear
                                    }
                                    .frame(width: 0, height: 0)
                                    ,alignment: .leading
                                
                                )
                        } else {
                            Image(backgroundsTitles[index])
                                .resizable()
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .overlay(
                    ZStack {
                        indicatorView()
                        textAndButtonView()
                    }
                )
            }
            .ignoresSafeArea()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                        guard let scene = UIApplication.shared.windows.first?.windowScene else { return }
                        self.isPortrait = scene.interfaceOrientation.isPortrait
                    }
    }
    
    private func nextButtonPressed() {
        if selection < 2 {
            increaseSelection()
        } else {
            toNext.send(true)
        }
    }
    
    private func increaseSelection() {
        withAnimation {
            selection += 1
        }
    }
    
    private func indicatorView() -> some View {
        HStack(spacing: 8) {
            Circle()
                .fill(Color.onboardingControls.opacity(opacityBy(index: 0)))
            Circle()
                .fill(Color.onboardingControls.opacity(opacityBy(index: 1)))
            Circle()
                .fill(Color.onboardingControls.opacity(opacityBy(index: 2)))
        }
        .frame(height: 8)
        .padding(.top, safeAreaInsets.top + 10)
        .frame(maxHeight: .infinity, alignment: .top)
    }
    
    private func opacityBy(index: Int) -> CGFloat {
        selection == index ? 1 : 0.3
    }
    
    private func textAndButtonView() -> some View {
        VStack(spacing: 16) {
            if isPortrait {
                TextCustom(text: textFor(selection: selection),
                           size: 28,
                           weight: .bold)
            } else {
                TextCustom(text: textFor(selection: selection),
                           size: 28,
                           weight: .bold)
                .shadow(color: .black, radius: 1)
            }
            NextButton(action: nextButtonPressed)
                .padding(.bottom, 8)
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .padding(.bottom, safeAreaInsets.bottom)
    }

    private func textFor(selection: Int) -> String {
        switch selection {
        case 0: return "Create your team and keep statistics"
        case 1: return "Keep stats on\nthe games"
        case 2: return "Add relevant information\nfor the team"
        default: return "Invalid onoarding index"
        }
    }
    
    private func getIndex() -> Int {
        Int(round(Double(offset / getWidth())))
    }
}

#Preview {
    OnboardingViewReviewer()
}

extension View {
    func getWidth() -> CGFloat {
        
        UIScreen.current?.bounds.width ?? 0
        
        //UIScreen.main.bounds.width
    }
}

extension UIWindow {
    static var current: UIWindow? {
        for scene in UIApplication.shared.connectedScenes {
            guard let windowScene = scene as? UIWindowScene else { continue }
            for window in windowScene.windows {
                if window.isKeyWindow { return window }
            }
        }
        return nil
    }
}


extension UIScreen {
    static var current: UIScreen? {
        UIWindow.current?.screen
    }
}
