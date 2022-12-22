import UIKit

final class PostCollectionView: UIViewController {
    private var textLabel: UILabel = .init(frame: .zero)
    
    private let viewModel = PostCollectionViewModel()
    
    override func loadView() {
        super.loadView()
        layout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        
        navigationItem.title = "PostCollectionView"
        textLabel.text = "PostCollectionView"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //TODO: use with collectionView
//        viewModel.getData { }
    }
}

extension PostCollectionView {
    private func layout() {
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
    private func style() {
        view.backgroundColor = .systemBackground
        textLabel.textColor = .label
    }
}
