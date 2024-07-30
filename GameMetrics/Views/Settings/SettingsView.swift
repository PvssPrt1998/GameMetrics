
import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack(spacing: 25) {
            GrabberView()
                .padding(EdgeInsets(top: 5, leading: 0, bottom: 18, trailing: 0))
            TextCustom(text: "Settings", size: 34, weight: .bold, color: .textMain)
                .padding(EdgeInsets(top: 3, leading: 16, bottom: 8, trailing: 16))
                .frame(maxWidth: .infinity, alignment: .leading)
            VStack(spacing: 0){
                VStack(spacing: 0) {
                    Button {
                        //action contact
                    } label: {
                        HStack(spacing: 12) {
                            Image(systemName: "bubble.fill")
                                .fontCustom(size: 20, weight: .semibold, color: .specialPrimary)
                            TextCustom(text: "Contact us", size: 16, weight: .bold, color: .settingsText)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .fontCustom(size: 20, weight: .semibold, color: .specialPrimary)
                        }
                    }
                    .padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10))
                    Divider()
                }
                VStack(spacing: 0) {
                    Button {
                        //action contact
                    } label: {
                        HStack(spacing: 12) {
                            Image(systemName: "wallet.pass.fill")
                                .fontCustom(size: 20, weight: .semibold, color: .specialPrimary)
                            TextCustom(text: "License", size: 16, weight: .bold, color: .settingsText)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .fontCustom(size: 20, weight: .semibold, color: .specialPrimary)
                        }
                    }
                    .padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10))
                    Divider()
                }
                VStack(spacing: 0) {
                    Button {
                        //action contact
                    } label: {
                        HStack(spacing: 12) {
                            Image(systemName: "menucard.fill")
                                .fontCustom(size: 20, weight: .semibold, color: .specialPrimary)
                            TextCustom(text: "Terms of use", size: 16, weight: .bold, color: .settingsText)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .fontCustom(size: 20, weight: .semibold, color: .specialPrimary)
                        }
                    }
                    .padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10))
                    Divider()
                }
                VStack(spacing: 0) {
                    Button {
                        //action contact
                    } label: {
                        HStack(spacing: 12) {
                            Image(systemName: "shield.fill")
                                .fontCustom(size: 20, weight: .semibold, color: .specialPrimary)
                            TextCustom(text: "Privacy", size: 16, weight: .bold, color: .settingsText)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .fontCustom(size: 20, weight: .semibold, color: .specialPrimary)
                        }
                    }
                    .padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10))
                }
            }
            
        }
    }
}

#Preview {
    SettingsView()
        .background(Color.white)
}
