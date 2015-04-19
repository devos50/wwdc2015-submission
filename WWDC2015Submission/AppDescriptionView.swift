//
//  AppDescriptionView.swift
//  WWDC2015Submission
//
//  Created by Martijn de Vos on 19-04-15.
//  Copyright (c) 2015 CodeUp. All rights reserved.
//

import Foundation
import UIKit

class AppDescriptionView: UIView
{
    var appDescriptionCircleView: AppDescriptionCircleView?
    var closeButton: UIButton?
    let appIconImageViewSize: CGFloat = 90
    let screenshotsButtonSize: CGFloat = 160
    var screenshotsButton: UIButton?
    var appIconImageView: UIImageView?
    var screenshotImageView: UIImageView?
    var showScreenshot = false
    var animationOffset: CGFloat?
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        let screenRect = UIScreen.mainScreen().bounds
        let screenWidth = screenRect.size.width
        let screenHeight = screenRect.size.height
        
        self.backgroundColor = UIColor(white: 0.3, alpha: 0.8)
        // self.hidden = true
        self.layer.cornerRadius = self.frame.size.width / 2
        self.layer.masksToBounds = true
        
        // add the sub view to the menu (80% of the screen width)
        let radius = screenWidth * 0.4
        appDescriptionCircleView = AppDescriptionCircleView(frame: CGRectMake(self.frame.size.width / 2 - radius, self.frame.size.height / 2 - radius, radius * 2, radius * 2))
        appDescriptionCircleView?.backgroundColor = UIColor.whiteColor()
        appDescriptionCircleView?.layer.cornerRadius = radius
        appDescriptionCircleView?.layer.masksToBounds = true
        
        self.addSubview(appDescriptionCircleView!)
        createCloseButton(radius)
        createAppIcon(radius)
        createScreenshotsButton()
        createScreenshot()
        
        animationOffset = self.screenshotsButton!.frame.origin.y - (self.frame.size.height - screenHeight) / 2 - 20
        
        // self.transform = CGAffineTransformMakeScale(0.01, 0.01)
    }
    
    func createCloseButton(radius: CGFloat)
    {
        closeButton = UIButton.buttonWithType(.System) as? UIButton
        closeButton?.frame = CGRectMake(appDescriptionCircleView!.center.x - radius / sqrt(2) - 20, appDescriptionCircleView!.center.y - radius / sqrt(2) - 20, 30, 30)
        closeButton?.backgroundColor = UIColor.blackColor()
        closeButton?.titleLabel?.font = UIFont.systemFontOfSize(19)
        closeButton?.setTitle("×", forState: .Normal)
        closeButton?.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        closeButton?.layer.cornerRadius = 15
        closeButton?.layer.masksToBounds = true
        closeButton?.addTarget(self, action: "closeButtonPressed:", forControlEvents: .TouchUpInside)
        
        self.addSubview(closeButton!)
    }
    
    func createAppIcon(radius: CGFloat)
    {
        appIconImageView = UIImageView(frame: CGRectMake(appDescriptionCircleView!.center.x - appIconImageViewSize / 2, appDescriptionCircleView!.center.y - radius - 130, appIconImageViewSize, appIconImageViewSize))
        appIconImageView?.layer.cornerRadius = appIconImageViewSize / 2
        appIconImageView?.layer.masksToBounds = true
        appIconImageView?.image = UIImage(named: "carambolecounterlogo")
        self.addSubview(appIconImageView!)
    }
    
    func createScreenshotsButton()
    {
        screenshotsButton = UIButton.buttonWithType(.System) as? UIButton
        screenshotsButton?.setTitle("Show Screenshot", forState: .Normal)
        screenshotsButton?.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        screenshotsButton?.titleLabel!.font = UIFont.boldSystemFontOfSize(17)
        screenshotsButton?.frame = CGRectMake(self.frame.size.width / 2 - screenshotsButtonSize / 2, appDescriptionCircleView!.frame.origin.y + appDescriptionCircleView!.frame.size.height + 30, screenshotsButtonSize, 30)
        screenshotsButton?.addTarget(self, action: "screenshotsButtonPressed:", forControlEvents: .TouchUpInside)
        
        self.addSubview(screenshotsButton!)
    }
    
    func createScreenshot()
    {
        let width: CGFloat = appDescriptionCircleView!.frame.size.width
        let height: CGFloat = width * 1.775
        screenshotImageView = UIImageView(frame: CGRectMake(self.frame.size.width / 2 - width / 2, screenshotsButton!.frame.origin.y + 70, width, height))
        screenshotImageView?.image = UIImage(named: "camusescreenshot")
        screenshotImageView?.alpha = 0.0
        
        self.addSubview(screenshotImageView!)
    }
    
    func screenshotsButtonPressed(button: UIButton)
    {
        UIView.animateWithDuration(0.8, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            let screenHeight = UIScreen.mainScreen().bounds.size.height
            
            var offsetY = self.animationOffset!
            
            if self.showScreenshot
            {
                self.screenshotsButton?.setTitle("Show Screenshot", forState: .Normal)
                offsetY = CGFloat(-1) * offsetY
            }
            else
            {
                self.screenshotsButton?.setTitle("Show App Info", forState: .Normal)
            }
            
            self.screenshotsButton!.center = CGPointMake(self.screenshotsButton!.center.x, self.screenshotsButton!.center.y - offsetY)
            self.appDescriptionCircleView!.center = CGPointMake(self.appDescriptionCircleView!.center.x, self.appDescriptionCircleView!.center.y - offsetY)
            self.closeButton!.center = CGPointMake(self.closeButton!.center.x, self.closeButton!.center.y - offsetY)
            self.appIconImageView!.center = CGPointMake(self.appIconImageView!.center.x, self.appIconImageView!.center.y - offsetY)
            self.screenshotImageView!.center = CGPointMake(self.screenshotImageView!.center.x, self.screenshotImageView!.center.y - offsetY)
            
            if !self.showScreenshot { self.screenshotImageView!.alpha = 1.0 }
            else { self.screenshotImageView!.alpha = 0.0 }
        }) { (b: Bool) -> Void in
            // ...
        }
        
        showScreenshot = !showScreenshot
    }

    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func closeButtonPressed(button: UIButton)
    {
        self.hidden = true
    }
}