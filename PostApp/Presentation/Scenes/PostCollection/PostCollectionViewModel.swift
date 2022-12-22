import Foundation

final class PostCollectionViewModel {
    // MARK: - Binding Properties
    private(set) var posts: [PostApiModel] = []
    private(set) var pageNumber = 0
    
    private let postRepository: PostRepository
    
    init(postRepository: PostRepository) {
        self.postRepository = postRepository
    }
    
    // MARK: - Public functions
    func getData(completion: @escaping () -> Void) {
        postRepository.getPosts(byPage: pageNumber) {  [weak self] (result) in
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
