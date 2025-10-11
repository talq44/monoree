import UIKit
//import AnimalQuizLabFeature

class ViewController: UIViewController {
    
    private let button = UIButton(configuration: .bordered())

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let label = UILabel()
        label.text = "Animal Quiz Lab"
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        
        button.configuration?.title = "next"
//        button.addAction(UIAction(handler: { [weak self] _ in
//            let vc = AQLCoordinator.home()
//            self?.navigationController?.pushViewController(vc, animated: true)
//        }), for: .touchUpInside)
    }
}
