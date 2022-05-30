import UIKit

public class SemiModalBlurPresentationController: SemiModalPresentationController {
    public override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        overlayView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        overlayView.alpha = 0.0
        presentationOverlayViewAlpha = 1.0
    }
}
