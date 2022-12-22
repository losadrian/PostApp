import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    private let apiClient = APIClient()
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let postCollectionViewModel = PostCollectionViewModel(postRepository: apiClient)
        let postCollectionViewController = PostCollectionView(postCollectionViewModel: postCollectionViewModel)
        let navigationController = UINavigationController(rootViewController: postCollectionViewController)
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
    }
}

