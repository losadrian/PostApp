import UIKit

class AsyncUIImageView: UIImageView {
    static let imageCache = NSCache<AnyObject, AnyObject>()
    
    final private var imageUrl: URL?
    private var dataTask: URLSessionDataTask?
    
    func loadImage(from urlString: String, placeholder: UIImage? = nil) {
        
        setImage(placeholder)
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        imageUrl = url
        
        if let cachedImage = AsyncUIImageView.imageCache.object(forKey: url as AnyObject) as? UIImage {
            self.setImage(cachedImage)
            return
        }
        
        if let task = dataTask {
            task.cancel()
        }
        dataTask = URLSession.shared.dataTask(with: imageUrl!) { (data, _, error) in
            guard let data = data, let image = UIImage(data: data) else {
                return
            }
            
            self.setImage(image)
            AsyncUIImageView.imageCache.setObject(image, forKey: url as AnyObject)
        }
        if let task = dataTask {
            task.resume()
        }
    }
    
    private func setImage(_ image: UIImage?) {
        DispatchQueue.main.async { [weak self] in
            self?.image = image
        }
    }
}

