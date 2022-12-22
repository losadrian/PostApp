import UIKit

final class PostCollectionView: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("PostCollectionView - viewDidLoad")
        
        //FIXME: where is the request going and why is it not coming back?
        let apiClient = APIClient()
        apiClient.getPosts(byPage: 0) { result in
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

