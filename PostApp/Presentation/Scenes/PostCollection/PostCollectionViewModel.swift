import Foundation

final class PostCollectionViewModel {
    // MARK: - Binding Properties
    private(set) var posts : [PostApiModel] = []
    private(set) var pageNumber = 0
    
    // MARK: - Public functions
    func getData(completion: @escaping () -> Void) {
        APIClient.shared.getPosts(byPage: pageNumber) {  [weak self] (result) in
            switch result {
            case .success(let posts):
                self?.posts.append(contentsOf: posts)
                self?.pageNumber = (self?.pageNumber ?? 0) + 1
                completion()
                break
            case .failure(let error):
                print(error)
            }
        }
    }
}
