

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: scene)
        self.window!.rootViewController = UINavigationController(rootViewController:RootViewController())
        self.window!.backgroundColor = .white
        self.window!.makeKeyAndVisible()
    }

}

