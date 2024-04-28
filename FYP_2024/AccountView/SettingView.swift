import SwiftUI

struct SettingView: View {
    @State private var darkModeEnabled: Bool = UserDefaults.standard.bool(forKey: "darkModeEnabled") {
        didSet {
            UserDefaults.standard.set(darkModeEnabled, forKey: "darkModeEnabled")
        }
    }

    var body: some View {
        List {
            Section {
                Toggle(isOn: $darkModeEnabled) {
                    Text("Dark Mode")
                }
            }
            // 其餘部分不變
            Section {
                NavigationLink(destination: LanguageView()) {
                    Text("Language")
                }
                NavigationLink(destination: PrivacyView()) {
                    Text("Privacy")
                }
                NavigationLink(destination: SecurityView()) {
                    Text("Security")
                }
            }
            Section {
                NavigationLink(destination: HelpView()) {
                    Text("Help")
                }
                NavigationLink(destination: AboutView()) {
                    Text("About")
                }
            }
        }
        .navigationTitle("Settings")
    }
}

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // 創建新的視圖
        let contentView = ContentView()

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)

            // 根據用戶設定選擇外觀模式
            if UserDefaults.standard.bool(forKey: "darkModeEnabled") {
                window.overrideUserInterfaceStyle = .dark
            } else {
                window.overrideUserInterfaceStyle = .light
            }

            self.window = window
            window.makeKeyAndVisible()
        }
    }
}




struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
