import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: windowScene)
        let view = ChatListView()
        let viewController = GenericViewController(with: view)
        view.delegate = viewController
        viewController.delegate = view
        viewController.title = "Chats"
        window?.rootViewController = UINavigationController(rootViewController: viewController)
        window?.makeKeyAndVisible()
    }
}
