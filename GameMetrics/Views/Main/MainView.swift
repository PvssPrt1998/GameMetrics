import SwiftUI

struct MainView: View {
    
    @ObservedObject var viewModel: MainViewModel
    
    @State var appearanceCoverColorOpacity: Double = 1
    
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    //Animation properties
    @State var first: CGFloat = 50
    @State var second: CGFloat = 50
    @State var third: CGFloat = 50
    @State var fourth: CGFloat = 50
    //
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        UIScrollView.appearance().bounces = true
    }
    
    var body: some View {
        VStack(spacing: 25) {
            TeamView(team: viewModel.team, action: viewModel.editButtonPressed)
                .padding(.top, first)
            MainButton(text: "Dota2 Statistics", imageTitle: "chart.line.uptrend.xyaxis", action: viewModel.dotaStatButtonPressed)
                .padding(.top, second)
            MainButton(text: "LoL Statistics", imageTitle: "chart.xyaxis.line", action: viewModel.lolStatButtonPressed)
                .padding(.top, third)
            MainButton(text: "Settings", imageTitle:  "gearshape.fill", action: viewModel.settingsButtonPressed)
                .padding(.top, fourth)
        }
        .padding(EdgeInsets(top: topPadding(), 
                            leading: horizontalPaddingForDevice(),
                            bottom: 0,
                            trailing: horizontalPaddingForDevice()))
        .frame(maxHeight: .infinity, alignment: .top)
        .overlay(
            Color.white.opacity(appearanceCoverColorOpacity)
        )
        .background(
            GeometryReader { proxy in
                Color.clear.onAppear {
                    viewModel.screenHeight = proxy.size.height + safeAreaInsets.bottom
                }
            }
        )
        .sheet(isPresented: $viewModel.showTeamEditSheet) {
            TeamEditView(viewModel: viewModel.teamEditViewModel) {
                viewModel.showTeamEditSheet = false
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .background(Color.white)
            .ignoresSafeArea()
        }
        .sheet(isPresented: $viewModel.showDotaStatSheet) {
            StatView(title: "Dota2 Statistics", screenHeight: viewModel.screenHeight, viewModel: viewModel.dotaStatViewModel)
                .frame(maxHeight: .infinity, alignment: .top)
                .background(Color.white)
                .ignoresSafeArea()
        }
        .sheet(isPresented: $viewModel.showLolStatSheet) {
            StatView(title: "LoL Statistics", screenHeight: viewModel.screenHeight, viewModel: viewModel.lolStatViewModel)
                .frame(maxHeight: .infinity, alignment: .top)
                .background(Color.white)
                .ignoresSafeArea()
        }
        .sheet(isPresented: $viewModel.showSettingsSheet) {
            SettingsView()
                .frame(maxHeight: .infinity, alignment: .top)
                .background(Color.white)
                .ignoresSafeArea()
        }
        .onAppear {
            withAnimation(.linear(duration: 0.3)) {
                appearanceCoverColorOpacity = 0
            }
            itemsBounce()
        }
    }
    
    private func topPadding() -> CGFloat {
        UIDevice.current.userInterfaceIdiom == .pad ? 104 : 19
    }
    
    private func itemsBounce() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.spring(duration: 0.2, bounce: 0.7)) {
                first = 0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.spring(duration: 0.2, bounce: 0.7)) {
                    second = 0
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation(.spring(duration: 0.2, bounce: 0.7)) {
                        third = 0
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        withAnimation(.spring(duration: 0.2, bounce: 0.7)) {
                            fourth = 0
                        }
                    }
                }
            }
        }
    }
    
    private func horizontalPaddingForDevice() -> CGFloat {
        UIDevice.current.userInterfaceIdiom == .pad ? 46 : 20
    }
}

#Preview {
    MainView(viewModel: MainViewModel(dataManager: DataManager()))
}
