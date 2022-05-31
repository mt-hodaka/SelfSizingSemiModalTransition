import UIKit
import SemiModalTransition

class CustomizeOverlayViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        if case let presentationController as SemiModalPresentationController = presentationController {
            presentationController.overlayView = UIView()
            presentationController.overlayView.backgroundColor = UIColor(patternImage: UIImage(systemName: "heart.fill")!)
            presentationController.overlayView.alpha = 0.0
            presentationController.presentationOverlayViewAlpha = 0.5
            presentationController.dismissalOverlayViewAlpha = 0.0
            view.translatesAutoresizingMaskIntoConstraints = false
            view.heightAnchor.constraint(equalToConstant: 300.0).isActive = true
        }

        view.backgroundColor = .systemPink
    }
}
