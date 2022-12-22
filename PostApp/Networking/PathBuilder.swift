import Foundation

class PathBuilder {
    // MARK: - Private properties
    private var path : String
    
    // MARK: - Initializers
    init() {
        self.path = ""
    }
    
    // MARK: - Path elements
    @discardableResult
    func post() -> PathBuilder {
        path.append("/post")
        return self
    }
    
    // MARK: - BUILD
    func build() -> String {
        return self.path
    }
}
