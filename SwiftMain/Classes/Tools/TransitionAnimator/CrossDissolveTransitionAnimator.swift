//
//  PopAnimator.swift
//  SwiftMain
//
//  Created by Harlan on 2019/1/29.
//  Copyright © 2019 Harlan. All rights reserved.
//

import UIKit

class CrossDissolveTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning
{
    let duration = 0.25
    var presenting = true
    var originFrame = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning)
    {
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        
        let containerView = transitionContext.containerView
        
        // For a Presentation:
        //      fromView = The presenting view.
        //      toView   = The presented view.
        // For a Dismissal:
        //      fromView = The presented view.
        //      toView   = The presenting view.
        let fromView = transitionContext.view(forKey: .from)!
        let toView = transitionContext.view(forKey: .to)!
        
        fromView.frame = transitionContext.initialFrame(for: fromViewController)
        toView.frame = transitionContext.finalFrame(for: toViewController)
        
        fromView.alpha = 1.0
        toView.alpha = 0.0
        
        containerView.addSubview(toView)
        
        let transitionDuration = self.transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: transitionDuration, animations: {
            fromView.alpha = 0.0
            toView.alpha = 1.0
        }) { finished in
            let wasCanceled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!wasCanceled)
        }
    }
}

/// 使用实例
/*
class Test1ViewController: UIViewController, UIViewControllerTransitioningDelegate
{
    func presentWithCustomTransitionAction()
    {
        let secondViewController = UIViewController()
        secondViewController.modalPresentationStyle = .fullScreen
        secondViewController.transitioningDelegate = self
        present(secondViewController, animated: true, completion: nil)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        return CrossDissolveTransitionAnimator()
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        return CrossDissolveTransitionAnimator()
    }
}
 */
