import Foundation

class RequestBuilder {
    // MARK: - Private properties
    private var hostAddress : String
    private var httpScheme : String = "https"
    private var httpPort : Int?
    private var components : URLComponents = URLComponents()
    private var httpMethod : NetworkMethod
    private var httpBodyRawData : Data?
    private var httpBodyModelData : Data?
    private var urlRequest : URLRequest = URLRequest(url: URL(fileURLWithPath: ""))
    private var headers : [String: String] = [:]
    private var queries : [String: String] = [:]
    private var withAuthentication : Bool = false
    
    // MARK: - Initializers
    init(networkMethod: NetworkMethod, hostAddress: String = "dummyapi.io", path: String) {
        self.httpScheme = "https"
        self.hostAddress = hostAddress
        self.httpMethod = networkMethod
        components.scheme = self.httpScheme
        components.host = self.hostAddress
        components.path = "/data/v1"+path
    }
    
    @discardableResult
    func model<T: Codable>(_ model: T) -> RequestBuilder {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(model)
            httpBodyModelData = data
            if let requestJSON = String(data: data, encoding: .utf8) {
                NSLog(" - Request json - \n\(requestJSON)")
            }
            else {
                NSLog(" - ERROR in Request json - ")
            }
            
        } catch let error {
            NSLog("Post request model parsing failed: \(error.localizedDescription)")
        }
        return self
    }
    
    @discardableResult
    func httpHeaders(_ additionalHTTPHeaders: [String: String]) -> RequestBuilder {
        for (key, value) in additionalHTTPHeaders {
            headers[key] = value
        }
        return self
    }
    
    @discardableResult
    func httpHeader(key: String, value: String) -> RequestBuilder {
        headers[key] = value
        return self
    }
    
    @discardableResult
    func queryItems(_ additionalQueryItems: [String: String]) -> RequestBuilder {
        for (key, value) in additionalQueryItems {
            queries[key] = value
        }
        return self
    }
    
    @discardableResult
    func queryItem(key: String, value: String) -> RequestBuilder {
        queries[key] = value
        return self
    }
    
    @discardableResult
    func withAuth() -> RequestBuilder {
        withAuthentication = true
        return self
    }
    
    @discardableResult
    func httpBody(bodyData: Data) -> RequestBuilder {
        if bodyData != Data() {
            httpBodyRawData = bodyData
        }
        return self
    }
    
    func build() -> URLRequest {
        
        components.queryItems = queries.compactMap { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let componentsURL = components.url else {
            NSLog("Failed to create base url")
            return URLRequest(url: URL(fileURLWithPath: ""))
        }
        
        urlRequest = URLRequest(url: componentsURL)
        urlRequest.httpMethod = httpMethod.rawValue
        
        headers["Accept"] = "application/json"
        for header in headers {
            urlRequest.addValue(header.value, forHTTPHeaderField: header.key)
        }
        
        if withAuthentication {
#warning("Should not store secrets on-device")
    let appIdKey: [UInt8] = [109, 115, 37, 129, 152, 197, 87, 181, 252, 4, 176, 116, 247, 6, 175, 61, 205, 247, 131, 126, 99, 72, 107, 85, 91, 64, 29, 181, 250, 253, 50, 208, 207, 61, 132, 17, 146, 52, 156, 94, 248, 195, 229, 28, 90, 46, 13, 55]

    var pureAppIdKey: String {
        return String(bytes: appIdKey.deobfuscated,
            encoding: .utf8) ?? ""
    }
    urlRequest.setValue(pureAppIdKey, forHTTPHeaderField: "app-id")
        }
        
        if let modelData = httpBodyModelData {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = modelData
        }
        
        if let urlRequestUrl = urlRequest.url {
            NSLog("\n - Request url - \(urlRequestUrl)")
        }
        else {
            NSLog(" - ERROR in Request url - ")
        }
        return self.urlRequest
    }
}
