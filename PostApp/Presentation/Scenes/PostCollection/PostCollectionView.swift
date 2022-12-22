import UIKit

final class PostCollectionView: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("PostCollectionView - viewDidLoad")
        
        APIClient.shared.getPosts(byPage: 0) { result in
            switch result {
            case .success(let posts):
                print(posts)
                break
            case .failure(let error):
                print(error)
            }
        }
    }
}

