//
//  CircleTransitionAnimator.swift
//  WWDC2015Submission
//
//  Created by Martijn de Vos on 4/18/15.
//  Copyright (c) 2015 CodeUp. All rights reserved.
//

import Foundation
import UIKit

class CircleTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning
{
    weak var transitionContext: UIViewControllerContextTransitioning?
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval
    {
        return 0.6
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning)
    {
        self.transitionContext = transitionContext
        
        var containerView = transitionContext.containerView()
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as UIViewController!
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)as UIViewController!
        
        var buttonFrame = CGRectZero
        if fromViewController is StartViewController
        {
            buttonFrame = (fromViewController as! StartViewController).startButton!.frame
        }
        else if fromViewController is AboutViewController
        {
            buttonFrame = (fromViewController as! AboutViewController).appsButton!.frame
        }
        else if fromViewController is AppsViewController
        {
            buttonFrame = (fromViewController as! AppsViewController).companyButton!.frame
        }
        
        containerView.addSubview(toViewController.view)
        
        var circleMaskPathInitial = UIBezierPath(ovalInRect: buttonFrame)
        var extremePoint = CGPoint(x: CGRectGetMidX(buttonFrame) - 0, y: CGRectGetMidY(buttonFrame) - CGRectGetHeight(toViewController.view.bounds))
        var radius = sqrt((extremePoint.x*extremePoint.x) + (extremePoint.y*extremePoint.y))
        
        if fromViewController is AboutViewController || fromViewController is AppsViewController
        {
            radius = sqrt(buttonFrame.origin.x * buttonFrame.origin.x + buttonFrame.origin.y * buttonFrame.origin.y) + buttonFrame.width
        }
        
        var circleMaskPathFinal = UIBezierPath(ovalInRect: CGRectInset(buttonFrame, -radius, -radius))
        
        var maskLayer = CAShapeLayer()
        maskLayer.path = circleMaskPathFinal.CGPath
        toViewController.view.layer.mask = maskLayer
        
        var maskLayerAnimation = CABasicAnimation(keyPath: "path")
        maskLayerAnimation.fromValue = circleMaskPathInitial.CGPath
        maskLayerAnimation.toValue = circleMaskPathFinal.CGPath
        maskLayerAnimation.duration = self.transitionDuration(transitionContext)
        maskLayerAnimation.delegate = self
        maskLayer.addAnimation(maskLayerAnimation, forKey: "path")
    }
    
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool)
    {
        self.transitionContext?.completeTransition(!self.transitionContext!.transitionWasCancelled())
        self.transitionContext?.viewControllerForKey(UITransitionContextFromViewControllerKey)?.view.layer.mask = nil
    }
}