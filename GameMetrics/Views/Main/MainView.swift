import SwiftUI

struct MainView: View {
    
    @ObservedObject var viewModel: MainViewModel
    
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        UIScrollView.appearance().bounces = true
    }
    
    var body: some View {
        VStack(spacing: 25) {
            TeamView(team: viewModel.team, action: viewModel.editButtonPressed)
            MainButton(text: "Dota2 Statistics", imageTitle: "chart.line.uptrend.xyaxis", action: viewModel.dotaStatButtonPressed)
            MainButton(text: "LoL Statistics", imageTitle: "chart.xyaxis.line", action: {})
            MainButton(text: "Settings", imageTitle:  "gearshape.fill", action: viewModel.settingsButtonPressed)
        }
        .padding(EdgeInsets(top: 19, 
                            leading: horizontalPaddingForDevice(),
                            bottom: 0,
                            trailing: horizontalPaddingForDevice()))
        .frame(maxHeight: .infinity, alignment: .top)
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
            StatView(title: "Dota2 Statistics", screenHeight: viewModel.screenHeight, viewModel: viewModel.statViewModel)
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
    }
    
    private func horizontalPaddingForDevice() -> CGFloat {
        UIDevice.current.userInterfaceIdiom == .pad ? 46 : 20
    }
}

#Preview {
    MainView(viewModel: MainViewModel(dataManager: DataManager()))
}
