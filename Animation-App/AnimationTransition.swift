//
//  AnimationTransition.swift
//  Animation-App
//
//  Created by Eldor Makkambaev on 01.05.2018.
//  Copyright © 2018 Eldor Makkambaev. All rights reserved.
//

import UIKit

class AnimationTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 1.0
    var presenting = true
    var originFrame = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        let fromView = transitionContext.view(forKey: .from)!
        
        containerView.addSubview(toView)
        toView.alpha = 0.0
        let nameLabel = fromView.subviews[2]
        let loginButton = fromView.subviews[4]
        
        
        toView.transform = CGAffineTransform.init(translationX: 1000, y: 0)
        
        UIView.animate(withDuration: duration) {
            toView.transform = CGAffineTransform.init(translationX: 0, y: 0)
        }
        
        UIView.animate(withDuration: duration,
                       animations: {
                        toView.alpha = 1.0
                        nameLabel.alpha = 0
                        loginButton.alpha = 0
                        
                        fromView.transform = CGAffineTransform.init(scaleX: 0.3, y: 0.3)
        },
                       completion: { _ in
                        fromView.subviews[3].subviews[0].transform = CGAffineTransform.init(scaleX: 0, y: 0)
                        transitionContext.completeTransition(true)
                        fromView.transform = CGAffineTransform.identity
                        nameLabel.alpha = 1
                        loginButton.alpha = 1
        }
        )
        
        
        
        let emailTextField = fromView.subviews[3].subviews[0]
        let passwordTextField = fromView.subviews[3].subviews[1]
        
        
        //emailTextField.transform = CGAffineTransform.init(translationX: 0, y: 0)
        UIView.transition(with: emailTextField, duration: duration, options: .beginFromCurrentState, animations: {
            emailTextField.transform = CGAffineTransform.init(translationX: 1000, y: 0)
            passwordTextField.transform = CGAffineTransform.init(translationX: -1000, y: 0)
        }) { (_) in
            emailTextField.transform = CGAffineTransform.init(translationX: 0, y: 0)
            passwordTextField.transform = CGAffineTransform.init(translationX: 0, y: 0)
        }
        
    }
    
    
}
