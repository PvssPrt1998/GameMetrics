import SwiftUI

struct StatView: View {
    
    let title: String
    let screenHeight: CGFloat
    
    @ObservedObject var viewModel: StatViewModel
    
    var body: some View {
        ZStack {
            ScrollView(.vertical) {
                VStack(spacing: 20) {
                    GrabberView()
                        .padding(5)
                    TextCustom(text: title, size: 34, weight: .bold, color: .textMain)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: 21, leading: -4, bottom: 8, trailing: -4))
                        .padding(.horizontal, 20)
                    InfoView(viewModel: viewModel.infoViewModel) {
                        viewModel.showEditStatSheet = true
                    }
                    .padding(.horizontal, 20)
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
                    .padding(.horizontal, 20)
                    
                    if viewModel.playersCount == 0 {
                        EmptyPlayersView {
                            viewModel.showAddPlayersView = true
                        }
                    } else {
                        ScrollView(.horizontal) {
                            LazyHStack(spacing: 14) {
                                ForEach(viewModel.players, id: \.self) { player in
                                    PlayerCard(player: player)
                                }
                            }
                            .padding(.horizontal, 20)
                        }
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
                    .padding(.horizontal, 20)
                    if viewModel.notesCount != 0 {
                        LazyVStack(spacing: 0) {
                            ForEach(0..<viewModel.notesCount, id: \.self) { index in
                                VStack(spacing: 0) {
                                    NoteCard(note: viewModel.getNoteBy(index: index))
                                        .padding(.horizontal, 20)
                                    if index != viewModel.notesCount - 1 {
                                        Rectangle()
                                            .fill(Color.textSecond)
                                            .frame(height: 1)
                                    }
                                }
                            }
                        }
                        
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
        }
        
    }
    
    
}

#Preview {
    StatView(title: "Dota2 stat", screenHeight: 844, viewModel: StatViewModel(gameData: DataManager().dotaData))
        .background(Color.white)
}
