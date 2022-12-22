import UIKit

final class PostCollectionView: UIViewController {
    private var textLabel: UILabel = .init(frame: .zero)
    
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
