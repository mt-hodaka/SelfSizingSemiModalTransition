import UIKit

public class SemiModalTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        SemiModalPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
