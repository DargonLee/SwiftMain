//
//  CustomPresentationController.swift
//  SwiftMain
//
//  Created by Harlan on 2019/1/29.
//  Copyright © 2019 Harlan. All rights reserved.
//

import UIKit

class CustomPresentationController: UIPresentationController,UIViewControllerAnimatedTransitioning
{
    public enum TransitionType {
        case fromBottomToTop  /// x == 0
        case fromTopToBottom
        case fromLeftToRight  /// y == 0
        case fromRightToLeft
    }
    
    private struct TransitionFrame {
        var toViewSize: CGSize?
        var toViewInitialOrigin: CGPoint?
        var toViewFinalOrigin: CGPoint?
        var fromViewFinalOrigin: CGPoint?
    }
    
    public var transitionType = TransitionType.fromBottomToTop
    
    convenience init(with presentedViewController: UIViewController, presentingViewController: UIViewController) {
        self.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        presentedViewController.modalPresentationStyle = .custom
    }
    
    
    
    override func presentationTransitionWillBegin()
    {
        containerView?.addSubview(dimmingView)
        
        presentingViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
           self.dimmingView.alpha = 0.7
        }, completion: nil)
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool)
    {
        if completed {
            //self.dimmingView.alpha = 0.5
        }
    }
    
    override func dismissalTransitionWillBegin()
    {
        presentingViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 0.0
        }, completion: nil)
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool)
    {
        if completed {
            dimmingView.removeFromSuperview()
        }
    }
    
    /// MARK
    override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer)
    {
        super.preferredContentSizeDidChange(forChildContentContainer: container)
        
        if container .isEqual(self.presentedViewController) {
            self.containerView?.setNeedsLayout()
        }
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize
    {
        if container .isEqual(self.presentedViewController)
        {
            return container.preferredContentSize
        }else {
            return super.size(forChildContentContainer: container, withParentContainerSize: parentSize)
        }
    }
    
    override func containerViewWillLayoutSubviews()
    {
        super.containerViewWillLayoutSubviews()
        dimmingView.frame = containerView?.bounds ?? CGRect.zero
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval
    {
        return transitionContext!.isAnimated ? 0.35 : 0
    }
    
    
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning)
    {
        let fromViewController = transitionContext.viewController(forKey: .from)!
        let toViewController = transitionContext.viewController(forKey: .to)!
        
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)
        toView?.backgroundColor = UIColor.red // 进场的view
        let fromView = transitionContext.view(forKey: .from)
        fromView?.backgroundColor = UIColor.yellow // 出场的view
        
        let isPresenting = (fromViewController == self.presentingViewController)
        
        _ = transitionContext.initialFrame(for: fromViewController)
        var fromViewFinalFrame = transitionContext.finalFrame(for: fromViewController)
        var toViewInitialFrame = transitionContext.initialFrame(for: toViewController)
        var toViewFinalFrame = transitionContext.finalFrame(for: toViewController)
        if toView != nil {
            containerView.addSubview(toView!)
        }
        
        ///
        let transitionFrame: TransitionFrame = getTransitionFrame(using: toViewController.preferredContentSize)
        toViewFinalFrame.origin = transitionFrame.toViewFinalOrigin!
        toViewFinalFrame.size = transitionFrame.toViewSize!
        
        if isPresenting {
            toViewInitialFrame.origin = transitionFrame.toViewInitialOrigin!
            toViewInitialFrame.size = transitionFrame.toViewSize!
            toView!.frame = toViewInitialFrame // 进场动画 初始位置
        }else {
            fromViewFinalFrame.origin = transitionFrame.fromViewFinalOrigin!
        }
        ///
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
            if isPresenting {
                toView!.frame = toViewFinalFrame // 进场动画 最后位置
            }else {
                fromView!.frame = fromViewFinalFrame // 出场动画
            }
        }) { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
    private func getTransitionFrame(using toViewSize: CGSize) -> TransitionFrame
    {
        let container = containerView!
        let containerHeight = container.bounds.size.height
        let y: CGFloat = containerHeight - toViewSize.height
        switch self.transitionType {
        case .fromBottomToTop:
            let frame = TransitionFrame(toViewSize: toViewSize, toViewInitialOrigin: CGPoint(x: 0, y: container.frame.maxY), toViewFinalOrigin: CGPoint(x: 0, y: y), fromViewFinalOrigin: CGPoint(x: 0, y: container.frame.maxY))
            return frame
        case .fromTopToBottom:
            let frame = TransitionFrame(toViewSize: toViewSize, toViewInitialOrigin: CGPoint(x: 0, y: -toViewSize.height), toViewFinalOrigin: CGPoint(x: 0, y: 0), fromViewFinalOrigin: CGPoint(x: 0, y: -container.frame.maxY))
            return frame
        case .fromLeftToRight:
            let frame = TransitionFrame(toViewSize: toViewSize, toViewInitialOrigin: CGPoint(x: -container.frame.maxX, y: 0), toViewFinalOrigin: CGPoint(x: 0, y: 0), fromViewFinalOrigin: CGPoint(x: -container.frame.maxX, y: 0))
            return frame
        case .fromRightToLeft:
            let frame = TransitionFrame(toViewSize: toViewSize, toViewInitialOrigin: CGPoint(x: container.frame.maxX, y: 0), toViewFinalOrigin: CGPoint(x: 0, y: 0), fromViewFinalOrigin: CGPoint(x: container.frame.maxX, y: 0))
            return frame
        }
    }
    
    @objc private func dimmingViewTapped(sender: UITapGestureRecognizer)
    {
        self.presentingViewController.dismiss(animated: true, completion: nil)
    }
    
    lazy var dimmingView: UIVisualEffectView = {
        let blur = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let hudView = UIVisualEffectView(effect: blur)
        hudView.alpha = 0.0
        hudView.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.flexibleWidth.rawValue | UIView.AutoresizingMask.flexibleHeight.rawValue)
        let tap = UITapGestureRecognizer(target: self, action: #selector(dimmingViewTapped))
        hudView.addGestureRecognizer(tap)
        return hudView
    }()
}

extension CustomPresentationController: UIViewControllerTransitioningDelegate
{
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return self
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
}

/* 用法
class AAPLCustomPresentationFirstViewController: UIViewController {
    func buttonAction() {
        let secondViewController = UIViewController()
        let presentationController = CustomPresentationController(with: secondViewController, presentingViewController: self)
        presentationController.transitionType = .fromBottomToTop
        secondViewController.transitioningDelegate = presentationController
        present(secondViewController, animated: true, completion: nil)
    }
}
*/
