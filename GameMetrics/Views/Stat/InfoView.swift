import SwiftUI

struct InfoView: View {
    
    @ObservedObject var viewModel: InfoViewModel
    
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Button {
                action()
            } label: {
                HStack(spacing: 5) {
                    Image(systemName: "pencil")
                        .fontCustom(size: 20, weight: .bold, color: .specialPrimary)
                    TextCustom(text: "Edit plan", size: 13, weight: .regular, color: .specialPrimary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            HStack {
                VStack(spacing: 5) {
                    TextCustom(text: "\(numberOfMatches())", size: 34, weight: .bold, color: .specialPrimary)
                    TextCustom(text: "Number of matches", size: 12, weight: .medium, color: .textSecond)
                }
                Spacer()
                ZStack {
                    Triangle()
                        .fill(Color.specialPrimary)
                        .frame(width: 6, height: 5)
                        .rotationEffect(.degrees(-180))
                        .frame(maxHeight: .infinity, alignment: .top)
                    Rectangle()
                        .fill(Color.specialPrimary)
                        .frame(width: 1)
                    Triangle()
                        .fill(Color.specialPrimary)
                        .frame(width: 6, height: 5)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                }.frame(height: 48)
                Spacer()
                VStack(spacing: 5) {
                    TextCustom(text: "\(tournamentPlace())", size: 34, weight: .bold, color: .specialPrimary)
                    TextCustom(text: "Team standings", size: 12, weight: .medium, color: .textSecond)
                }
            }.frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
        .background(Color.bgSecond)
        .clipShape(.rect(cornerRadius: 5))
    }
    
    private func numberOfMatches() -> Int {
        viewModel.stat != nil ? viewModel.stat!.numberOfMatches : 0
    }
    
    private func tournamentPlace() -> Int {
        viewModel.stat != nil ? viewModel.stat!.tournamentPlace : 0
    }
}

#Preview {
    InfoView(viewModel: InfoViewModel(gameData: DataManager().dotaData), action: {
        
    })
        .background(Color.white)
}
