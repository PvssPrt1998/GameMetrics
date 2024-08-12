
import SwiftUI

struct SettingsView: View {
    
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    @State private var isPortrait = true
    let closeSheetAction: () -> Void
    
    @State var showContacts = false
    @State var showTermsOfUse = false
    @State var showPrivacy = false
    @State var showLicense = false
    
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: true) {
                VStack(spacing: 25) {
                    ZStack {
                        VStack(spacing: 25) {
                            if isPortrait {
                                GrabberView()
                                    .padding(EdgeInsets(top: 5, leading: 0, bottom: 18, trailing: 0))
                            }
                            
                            TextCustom(text: "Settings", size: 34, weight: .bold, color: .textMain)
                                .padding(EdgeInsets(top: 3, leading: 16, bottom: 8, trailing: 16))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        if !isPortrait {
                            Button {
                                closeSheetAction()
                            } label: {
                                Image(systemName: "xmark")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColorCustom(.black)
                                    .frame(width: 24, height: 24)
                            }
                            .padding(.top, 16)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                        }
                    }
                    
                    
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
                .padding(.bottom, safeAreaInsets.bottom)
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
        .padding(.horizontal, max(safeAreaInsets.leading, safeAreaInsets.trailing))
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                        guard let scene = UIApplication.shared.windows.first?.windowScene else { return }
                        self.isPortrait = scene.interfaceOrientation.isPortrait
                    }
    }
}

#Preview {
    SettingsView(closeSheetAction: {})
        .background(Color.white)
}
