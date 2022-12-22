import UIKit

final class PostDetailsView: UIViewController {
    private var postPictureImageView: AsyncUIImageView = .init(frame: .zero)
    private var commentTextLabel: UILabel = .init(frame: .zero)
    private var dateOfpublishLabel: UILabel = .init(frame: .zero)
    private var posterUserImageView: AsyncUIImageView = .init(frame: .zero)
    private var posterUserNameLabel: UILabel = .init(frame: .zero)
    private let likeImageView = UIImageView(image: UIImage(systemName: "hand.thumbsup.fill"))
    private var likeCountLabel: UILabel = .init(frame: .zero)
    
    private let posterUserImageSize: CGFloat = 50.0
    private let defaultSpacing: CGFloat = 10.0
    
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
        
        commentTextLabel.text = post.text
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateOfpublishLabel.text = "Date of publish \(dateFormatter.string(from: post.publishDate))"
        likeCountLabel.text = String(post.likes)
        postPictureImageView.loadImage(from: post.image)
        posterUserImageView.loadImage(from: post.owner.picture)
        posterUserNameLabel.text = "\(post.owner.title). \(post.owner.firstName) \(post.owner.lastName)"
        
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
        
        likeCountLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(likeCountLabel)
        NSLayoutConstraint.activate([
            likeCountLabel.bottomAnchor.constraint(equalTo: postPictureImageView.topAnchor, constant: -defaultSpacing),
            likeCountLabel.leadingAnchor.constraint(equalTo: postPictureImageView.trailingAnchor),
        ])
        
        likeImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(likeImageView)
        NSLayoutConstraint.activate([
            likeImageView.topAnchor.constraint(equalTo: likeCountLabel.topAnchor),
            likeImageView.trailingAnchor.constraint(equalTo: likeCountLabel.leadingAnchor, constant: -5),
        ])
        
        commentTextLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(commentTextLabel)
        NSLayoutConstraint.activate([
            commentTextLabel.bottomAnchor.constraint(equalTo: postPictureImageView.topAnchor, constant: -defaultSpacing),
            commentTextLabel.leadingAnchor.constraint(equalTo: postPictureImageView.leadingAnchor),
            commentTextLabel.trailingAnchor.constraint(equalTo: likeImageView.leadingAnchor),
        ])
        
        posterUserImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(posterUserImageView)
        NSLayoutConstraint.activate([
            posterUserImageView.widthAnchor.constraint(equalToConstant: posterUserImageSize),
            posterUserImageView.heightAnchor.constraint(equalToConstant: posterUserImageSize),
            posterUserImageView.topAnchor.constraint(equalTo: postPictureImageView.bottomAnchor, constant: defaultSpacing),
            posterUserImageView.leadingAnchor.constraint(equalTo: postPictureImageView.leadingAnchor),
        ])
        
        posterUserNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(posterUserNameLabel)
        NSLayoutConstraint.activate([
            posterUserNameLabel.topAnchor.constraint(equalTo: postPictureImageView.bottomAnchor, constant: defaultSpacing),
            posterUserNameLabel.leadingAnchor.constraint(equalTo: posterUserImageView.trailingAnchor, constant: defaultSpacing),
        ])
        
        dateOfpublishLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dateOfpublishLabel)
        NSLayoutConstraint.activate([
            dateOfpublishLabel.topAnchor.constraint(equalTo: posterUserNameLabel.bottomAnchor, constant: defaultSpacing),
            dateOfpublishLabel.leadingAnchor.constraint(equalTo: posterUserImageView.trailingAnchor, constant: defaultSpacing),
        ])
        
        
    }
    
    private func style() {
        view.backgroundColor = .systemBackground
        postPictureImageView.contentMode = .scaleAspectFit
        
        commentTextLabel.numberOfLines = 0
        
        posterUserImageView.layer.masksToBounds = false
        posterUserImageView.layer.borderColor = UIColor.black.cgColor
        posterUserImageView.layer.cornerRadius = posterUserImageSize/2
        posterUserImageView.clipsToBounds = true
        
        posterUserNameLabel.font = .systemFont(ofSize: 16, weight: .bold)
        posterUserNameLabel.textColor = .label
        posterUserNameLabel.textAlignment = .left
        
        dateOfpublishLabel.font = .systemFont(ofSize: 12)
        dateOfpublishLabel.textColor = .label
        dateOfpublishLabel.textAlignment = .right
    }
}
