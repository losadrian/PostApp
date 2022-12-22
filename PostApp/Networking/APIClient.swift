import Foundation
import Combine

final class APIClient: APIClientType {
    
    private var cancellationToken: AnyCancellable?
    
    func cancel() {
        if let token = cancellationToken {
            token.cancel()
        }
    }
}

// MARK: - PostRepository
extension APIClient: PostRepository {
    func getPosts(byPage page: Int, completion: @escaping (Result<[PostApiModel], Error>) -> Void) {
        //TODO: missing network call
    }
    
    
}
