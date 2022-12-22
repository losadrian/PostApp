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
        let additionalQueryItems: [String: String] = ["limit":"50","page":String(page)]
        
        let getPostsByPagePath = PathBuilder().post().build()
        let getPostsByPageRequest = RequestBuilder(networkMethod: .GET, path: getPostsByPagePath)
            .queryItems(additionalQueryItems)
            .withAuth()
            .build()
        let getPostsByPagePublisher = NetworkPublisher(urlRequest: getPostsByPageRequest).anyPublisher(type: PostListByPageResponseApiModel.self)
        
        cancellationToken = getPostsByPagePublisher.sink(receiveCompletion: { cancellableCompletion in
            if case let .failure(error as APIError) = cancellableCompletion {
                completion(.failure(error))
            }
        }, receiveValue: { getPostsByPageResponse in
            completion(.success(getPostsByPageResponse.data))
        })
    }
}
