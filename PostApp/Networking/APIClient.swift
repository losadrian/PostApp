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
