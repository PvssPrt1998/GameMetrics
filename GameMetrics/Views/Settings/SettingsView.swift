
import SwiftUI

struct SettingsView: View {
    
    @State var showContacts = false
    @State var showTermsOfUse = false
    @State var showPrivacy = false
    @State var showLicense = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 25) {
                GrabberView()
                    .padding(EdgeInsets(top: 5, leading: 0, bottom: 18, trailing: 0))
                TextCustom(text: "Settings", size: 34, weight: .bold, color: .textMain)
                    .padding(EdgeInsets(top: 3, leading: 16, bottom: 8, trailing: 16))
                    .frame(maxWidth: .infinity, alignment: .leading)
                VStack(spacing: 0){
                    VStack(spacing: 0) {
                        Button {
                            showContacts = true
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
                            showLicense = true
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
                            showTermsOfUse = true
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
                            showPrivacy = true
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
            
            if showContacts {
                SettingsWebView(action: {
                    showContacts = false
                }, url: "https://www.termsfeed.com/live/35a4a3ea-7384-4d62-af55-c414bea36c3c")
            }
            
            if showTermsOfUse {
                SettingsWebView(action: {
                    showTermsOfUse = false
                }, url: "https://www.termsfeed.com/live/b37a1f23-c239-4900-8a6b-22d1b03bacde")
            }
            if showPrivacy {
                SettingsWebView(action: {
                    showPrivacy = false
                }, url: "https://www.termsfeed.com/live/35a4a3ea-7384-4d62-af55-c414bea36c3c")
            }
            if showLicense {
                SettingsWebView(action: {
                    showLicense = false
                }, url: "https://www.termsfeed.com/live/b37a1f23-c239-4900-8a6b-22d1b03bacde")
            }
        }
    }
}

#Preview {
    SettingsView()
        .background(Color.white)
}
