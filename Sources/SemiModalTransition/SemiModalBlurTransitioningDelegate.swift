import UIKit

public class SemiModalBlurTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        SemiModalBlurPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
