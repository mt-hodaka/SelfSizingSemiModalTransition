import UIKit
import SemiModalTransition

class ViewController: UIViewController {
    private var transitioning: UIViewControllerTransitioningDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func didTapGrayedOut(_ sender: Any) {
        transitioning = SemiModalTransitioningDelegate()

        let vc = UIViewController()
        vc.view.backgroundColor = .systemYellow
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        vc.view.heightAnchor.constraint(equalToConstant: 300.0).isActive = true
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = transitioning

        present(vc, animated: true)
    }

    @IBAction func didTapBlur(_ sender: Any) {
        transitioning = SemiModalBlurTransitioningDelegate()

        let vc = TableViewController()
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = transitioning

        present(vc, animated: true)
    }

    @IBAction func didTapCustomize(_ sender: Any) {
        transitioning = SemiModalTransitioningDelegate()

        let vc = CustomizeOverlayViewController()
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = transitioning

        present(vc, animated: true)
    }
}
