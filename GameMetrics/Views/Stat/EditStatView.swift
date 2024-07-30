import SwiftUI

struct EditStatView: View {
    
    @ObservedObject var viewModel: EditStatViewModel
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 15) {
            GrabberView()
                .padding(.top, 5)
            TextCustom(text: "Edit statistic", size: 15, weight: .bold, color: .textMain)
                .padding(.horizontal, 16)
            Divider()
                .padding(.bottom, 5)
            
            EditTextField(text: $viewModel.numberOfMathcesText, label: "Number of matches", placeholder: "Enter")
                .onChange(of: viewModel.numberOfMathcesText, perform: { newValue in
                    numberValidation(newValue)
                })
                .keyboardType(.numberPad)
                .padding(.horizontal, 20)
            EditTextField(text: $viewModel.tournamentPlaceText, label: "Tournament place", placeholder: "Enter")
                .onChange(of: viewModel.tournamentPlaceText, perform: { newValue in
                    tournamentValidation(newValue)
                })
                .keyboardType(.numberPad)
                .padding(.horizontal, 20)
            PrimaryButton(title: "Save", disabled: buttonDisabled()) {
                viewModel.setStat()
                action()
            }
            .padding(.horizontal, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
    
    private func buttonDisabled() -> Bool {
        (viewModel.numberOfMathcesText != "" && viewModel.tournamentPlaceText != "") ? false : true
    }
    
    private func numberValidation(_ newValue: String) {
        let filtered = newValue.filter { Set("0123456789").contains($0) }

        if filtered != "" {
            viewModel.numberOfMathcesText = filtered
        } else {
            viewModel.numberOfMathcesText = ""
        }
    }
    
    private func tournamentValidation(_ newValue: String) {
        let filtered = newValue.filter { Set("0123456789").contains($0) }

        if filtered != "" {
            viewModel.tournamentPlaceText = filtered
        } else {
            viewModel.tournamentPlaceText = ""
        }
    }
}

#Preview {
    EditStatView(viewModel: EditStatViewModel(dataManager: DataManager()), action: {})
        .background(Color.white)
}
