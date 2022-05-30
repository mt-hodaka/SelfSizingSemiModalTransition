import UIKit

public class SemiModalPresentationController: UIPresentationController {
    public lazy var overlayView: UIView = {
        let v = UIView()
        v.backgroundColor = .black
        v.alpha = 0.0
        return v
    }()

    public var presentationOverlayViewAlpha = CGFloat(0.5)
    public var dismissalOverlayViewAlpha = CGFloat(0.0)

    public var dismissesOnOverlayTapping = true {
        didSet {
            overlayTapGestureRecognizer.isEnabled = dismissesOnOverlayTapping
        }
    }

    open func presentationAlongsideTransition(_ context: UIViewControllerTransitionCoordinatorContext) {
        overlayView.alpha = presentationOverlayViewAlpha
    }

    open func dismissalAlongsideTransition(_ context: UIViewControllerTransitionCoordinatorContext) {
        overlayView.alpha = dismissalOverlayViewAlpha
    }

    private var presentedViewConstraints = [NSLayoutConstraint]()
    private lazy var overlayTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapOverlayView(_:)))

    @objc
    private func didTapOverlayView(_ sender: UITapGestureRecognizer) {
        presentedViewController.dismiss(animated: true, completion: nil)
    }

    // MARK: - overrides

    public override func containerViewWillLayoutSubviews() {
        guard let containerView = containerView, let presentedView = presentedView else {
            return
        }

        overlayView.frame = containerView.frame

        presentedView.translatesAutoresizingMaskIntoConstraints = false

        presentedView.removeConstraints(presentedViewConstraints)

        presentedViewConstraints = [
            presentedView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            presentedView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            presentedView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ]

        if let scrollView = presentedView as? UIScrollView {
            let heightConstraint = scrollView.heightAnchor.constraint(
                equalToConstant: scrollView.contentSize.height
                + scrollView.safeAreaInsets.top
                + scrollView.safeAreaInsets.bottom
            )
            heightConstraint.priority = .defaultHigh

            let maxHeightConstraint = scrollView.heightAnchor.constraint(lessThanOrEqualTo: containerView.heightAnchor, constant: -44.0)

            presentedViewConstraints.append(contentsOf: [heightConstraint, maxHeightConstraint])

            scrollView.alwaysBounceVertical = false
        }

        NSLayoutConstraint.activate(presentedViewConstraints)
    }

    public override func containerViewDidLayoutSubviews() {
    }

    public override func presentationTransitionWillBegin() {
        guard let containerView = containerView else { return }

        overlayView.frame = containerView.bounds
        overlayView.addGestureRecognizer(overlayTapGestureRecognizer)
        containerView.insertSubview(overlayView, at: 0)

        presentingViewController.beginAppearanceTransition(false, animated: false)

        presentedViewController.transitionCoordinator?.animate(
            alongsideTransition: presentationAlongsideTransition,
            completion: nil
        )
    }

    public override func presentationTransitionDidEnd(_ completed: Bool) {
        if completed {
            presentingViewController.endAppearanceTransition()
        }
    }

    public override func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator?.animate(
            alongsideTransition: { context in
                self.presentingViewController.beginAppearanceTransition(true, animated: false)
                self.dismissalAlongsideTransition(context)
            },
            completion: nil
        )
    }

    public override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            overlayView.removeFromSuperview()
            presentingViewController.endAppearanceTransition()
        }
    }
}
