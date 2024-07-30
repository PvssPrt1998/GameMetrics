import SwiftUI

struct StatView: View {
    
    let title: String
    let screenHeight: CGFloat
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @ObservedObject var viewModel: StatViewModel
    
    @State var first: CGFloat = 50
    @State var second: CGFloat = 50
    @State var third: CGFloat = 50
    
    var body: some View {
        ZStack {
            ScrollView(.vertical) {
                VStack(spacing: itemSpacing()) {
                    GrabberView()
                        .padding(5)
                        .hidden()
                    TextCustom(text: title, size: 34, weight: .bold, color: .textMain)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: 21, leading: -4, bottom: 8, trailing: -4))
                        .padding(.horizontal, 20)
                    InfoView(viewModel: viewModel.infoViewModel) {
                        viewModel.showEditStatSheet = true
                    }
                    .padding(.horizontal, horizontalPadding())
                    .padding(.top, first)
                    HStack {
                        TextCustom(text: "Team composition", size: 22, weight: .bold, color: .black)
                        Spacer()
                        if viewModel.playersCount != 0 {
                            Button {
                                viewModel.showAddPlayersView = true
                            } label: {
                                Image(systemName: "plus")
                                    .fontCustom(size: 22, weight: .medium, color: .specialPrimary)
                                    .frame(width: 24, height: 24)
                            }
                        }
                    }
                    .padding(.horizontal, horizontalPadding())
                    
                    if viewModel.playersCount == 0 {
                        EmptyPlayersView {
                            viewModel.showAddPlayersView = true
                        }
                        .padding(.top, second)
                    } else {
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 14) {
                                ForEach(viewModel.players, id: \.self) { player in
                                    PlayerCard(player: player)
                                }
                            }
                            .padding(.horizontal, horizontalPadding())
                        }
                        .padding(.top, second)
                    }
                    
                    HStack {
                        TextCustom(text: "Notes", size: 22, weight: .bold, color: .black)
                        Spacer()
                        Button {
                            viewModel.showAddNotesView = true
                        } label: {
                            Image(systemName: "plus")
                                .fontCustom(size: 22, weight: .medium, color: .specialPrimary)
                                .frame(width: 24, height: 24)
                        }
                    }
                    .padding(.horizontal, horizontalPadding())
                    if viewModel.notesCount != 0 {
                        LazyVStack(spacing: 0) {
                            ForEach(0..<viewModel.notesCount, id: \.self) { index in
                                VStack(spacing: 0) {
                                    NoteCard(note: viewModel.getNoteBy(index: index))
                                    if index != viewModel.notesCount - 1 {
                                        Rectangle()
                                            .fill(Color.textSecond)
                                            .frame(height: 1)
                                    }
                                }
                            }
                        }
                        .padding(.bottom, safeAreaInsets.bottom)
                        .padding(.top, third)
                    }
                }
                
                .frame(maxHeight: .infinity, alignment: .top)
            }
            .sheet(isPresented: $viewModel.showAddPlayersView) {
                AddPlayersView(viewModel: viewModel.makeAddPlayersViewModel()) {
                    viewModel.showAddPlayersView = false
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .background(Color.white)
                .ignoresSafeArea()
            }
            .sheet(isPresented: $viewModel.showAddNotesView) {
                AddNotesView(viewModel: viewModel.makeAddNotesViewModel()) { 
                    viewModel.showAddNotesView = false
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .background(Color.white)
                .ignoresSafeArea()
            }
            
            
            if viewModel.showEditStatSheet {
                Color.black.opacity(0.2)
                EditStatView(viewModel: viewModel.makeEditStatViewModel(),
                             sheetSizeManager: SheetSizeManager(screenHeight: screenHeight),
                             showSheet: $viewModel.showEditStatSheet)
            }
            GrabberView()
                .padding(5)
                .frame(maxHeight: .infinity, alignment: .top)
        }
        .onAppear { itemsMove() }
        
    }
    
    private func horizontalPadding() -> CGFloat {
        UIDevice.current.userInterfaceIdiom == .pad ? 50 : 16
    }
    
    private func itemSpacing() -> CGFloat {
        UIDevice.current.userInterfaceIdiom == .pad ? 40 : 20
    }
    
    private func itemsMove() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
            withAnimation(.linear(duration: 0.2)) {
                first = 0
                second = 0
                third = 0
            }
        }
    }
}

#Preview {
    StatView(title: "Dota2 stat", screenHeight: 844, viewModel: StatViewModel(gameData: DataManager().dotaData))
        .background(Color.white)
}
