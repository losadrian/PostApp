import UIKit

final class PostDetailsView: UIViewController {
    private var postPictureImageView: AsyncUIImageView = .init(frame: .zero)
    
    private let post: PostApiModel
    
    init(selectedPost: PostApiModel) {
        self.post = selectedPost
            super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        layout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        
        
        postPictureImageView.loadImage(from: post.image)
    }
}

extension PostDetailsView {
    private func layout() {
        postPictureImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(postPictureImageView)
        NSLayoutConstraint.activate([
            postPictureImageView.widthAnchor.constraint(equalToConstant: view.frame.width*0.75),
            postPictureImageView.heightAnchor.constraint(equalToConstant: view.frame.height*0.25),
            postPictureImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            postPictureImageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
        ])
        
    }
    
    private func style() {
        view.backgroundColor = .systemBackground
        postPictureImageView.contentMode = .scaleAspectFit
    }
}
