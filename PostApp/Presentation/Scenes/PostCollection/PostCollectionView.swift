import UIKit

final class PostCollectionView: UIViewController {
    private let postCardSpacing: CGFloat = 20.0
    private let postCardColoumnNumber: CGFloat = 2.0
    
    private let viewModel = PostCollectionViewModel()
    
    private let postCollection: UICollectionView = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        return collectionView
    }()
    
    override func loadView() {
        super.loadView()
        layout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        setDelegates()
        
        navigationItem.title = "Posts"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getData { [weak self] in
            self?.postCollection.reloadData()
        }
    }
    
    
    private func setDelegates() {
        postCollection.delegate = self
        postCollection.dataSource = self
        postCollection.prefetchDataSource = self
        postCollection.alwaysBounceVertical = false
        postCollection.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: PostCollectionViewCell.identifier)
    }
}

extension PostCollectionView {
    private func layout() {
        postCollection.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(postCollection)
        
        NSLayoutConstraint.activate([
            postCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            postCollection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            postCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            postCollection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    private func style() {
        view.backgroundColor = .systemBackground
        postCollection.backgroundColor = .systemBackground
    }
}

extension PostCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.posts.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = postCollection.dequeueReusableCell(withReuseIdentifier: PostCollectionViewCell.identifier, for: indexPath) as? PostCollectionViewCell
        else { preconditionFailure() }
        let postAtIndexPath = viewModel.posts[indexPath.row]
        cell.configureCell(postPictureImageUrl: postAtIndexPath.image, commentText: postAtIndexPath.text, dateOfpublish: postAtIndexPath.publishDate)
        
        return cell
    }
}

extension PostCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension PostCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: postCardSpacing, bottom: 0, right: postCardSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return postCardSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return postCardSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width  = (postCollection.frame.width - ((postCardColoumnNumber + 1) * postCardSpacing)) / postCardColoumnNumber
        let height  = (postCollection.frame.width * 0.37)
        return CGSize(width: width, height: height)
    }
}

extension PostCollectionView: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if let maxRow = indexPaths.max() {
            print(maxRow.row)
            if maxRow.row >= viewModel.posts.count - 25 {
                viewModel.getData { [weak self] in
                    self?.postCollection.reloadData()
                }
            }
        }
    }
}
