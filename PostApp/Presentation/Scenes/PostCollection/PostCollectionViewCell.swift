import UIKit

final class PostCollectionViewCell: UICollectionViewCell {
    
    private var postPictureImageView: UIImageView = .init(frame: .zero)
    private var commentTextLabel: UILabel = .init(frame: .zero)
    private var dateOfpublishLabel: UILabel = .init(frame: .zero)
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layout()
        style()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        layout()
        style()
    }
    
    func configureCell(postPictureImageUrl: String, commentText: String, dateOfpublish: String) {
        commentTextLabel.text = commentText
        dateOfpublishLabel.text = dateOfpublish
        postPictureImageView.backgroundColor = .red
    }
}

extension PostCollectionViewCell {
    private func layout() {
        
        postPictureImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(postPictureImageView)
        NSLayoutConstraint.activate([
            postPictureImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            postPictureImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            postPictureImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -30),
            postPictureImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
        ])
        
        commentTextLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(commentTextLabel)
        NSLayoutConstraint.activate([
            commentTextLabel.topAnchor.constraint(equalTo: postPictureImageView.bottomAnchor, constant: 3),
            commentTextLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            commentTextLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
        ])
        
        dateOfpublishLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dateOfpublishLabel)
        NSLayoutConstraint.activate([
            dateOfpublishLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            dateOfpublishLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -3),
            dateOfpublishLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
        ])
    }
    
    private func style() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 5
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.5
        contentView.layer.shadowOffset = CGSize(width: 0, height: 5)
        contentView.layer.shadowRadius = 2
        
        postPictureImageView.contentMode = .scaleAspectFit
        
        commentTextLabel.font = .systemFont(ofSize: 10, weight: .bold)
        commentTextLabel.textColor = .black
        commentTextLabel.textAlignment = .left
        
        dateOfpublishLabel.font = .systemFont(ofSize: 10)
        dateOfpublishLabel.textColor = .black
        dateOfpublishLabel.textAlignment = .right
    }
}

extension PostCollectionViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
