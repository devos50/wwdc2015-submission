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
    var screenshotCloseButton: UIButton?
    let appIconImageViewSize: CGFloat = 90
    let screenshotsButtonSize: CGFloat = 160
    var screenshotsButton: UIButton?
    var appIconImageView: UIImageView?
    var screenshotImageViews = [UIImageView]()
    var showScreenshot = false
    var animationOffset: CGFloat?
    var leftArrowButton: UIButton?
    var rightArrowButton: UIButton?
    var nextScreenshotButton: UIButton?
    var prevScreenshotButton: UIButton?
    var screenshotDownButton: UIButton?
    var radius: CGFloat?
    var activeAppIndex = 0
    var activeScreenshotIndex = 0
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        let screenRect = UIScreen.mainScreen().bounds
        let screenWidth = screenRect.size.width
        let screenHeight = screenRect.size.height
        
        self.backgroundColor = UIColor(white: 0.3, alpha: 0.8)
        self.hidden = true
        self.layer.cornerRadius = self.frame.size.width / 2
        self.layer.masksToBounds = true
        
        // add the sub view to the menu (80% of the screen width)
        radius = screenWidth * 0.4
        appDescriptionCircleView = AppDescriptionCircleView(frame: CGRectMake(self.frame.size.width / 2 - radius!, self.frame.size.height / 2 - radius!, radius! * 2, radius! * 2))
        appDescriptionCircleView?.backgroundColor = UIColor.whiteColor()
        appDescriptionCircleView?.layer.cornerRadius = radius!
        appDescriptionCircleView?.layer.masksToBounds = true
        
        self.addSubview(appDescriptionCircleView!)
        createCloseButton()
        createAppIcon()
        createScreenshotsButton()
        createScreenshotDownButton()
        createScreenshots()
        createScreenshotCloseButton()
        createScreenshotNextPrevButtons()
        
        createNavigationButtons()
        
        animationOffset = self.screenshotsButton!.frame.origin.y - (self.frame.size.height - screenHeight) / 2 - 20
        
        // add swipe recognizers
        let swipeRight = UISwipeGestureRecognizer(target: self, action: "leftSwipeDetected")
        swipeRight.direction = .Right
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: "rightSwipeDetected")
        swipeRight.direction = .Left
        let swipeUp = UISwipeGestureRecognizer(target: self, action: "upSwipeDetected")
        swipeUp.direction = .Up
        self.addGestureRecognizer(swipeRight)
        self.addGestureRecognizer(swipeLeft)
        self.addGestureRecognizer(swipeUp)
        
        self.transform = CGAffineTransformMakeScale(0.01, 0.01)
    }
    
    func createCloseButton()
    {
        closeButton = CloseButton.getCloseButton()
        closeButton?.frame = CGRectMake(appDescriptionCircleView!.center.x - radius! / sqrt(2) - 20, appDescriptionCircleView!.center.y - radius! / sqrt(2) - 20, 30, 30)
        closeButton?.addTarget(self, action: "closeButtonPressed:", forControlEvents: .TouchUpInside)
        
        self.addSubview(closeButton!)
    }
    
    func createScreenshotCloseButton()
    {
        screenshotCloseButton = CloseButton.getCloseButton()
        screenshotCloseButton?.frame = CGRectMake(screenshotImageViews[0].frame.origin.x - 20, screenshotImageViews[0].frame.origin.y - 20, 30, 30)
        screenshotCloseButton?.addTarget(self, action: "closeButtonPressed:", forControlEvents: .TouchUpInside)
        screenshotCloseButton?.alpha = 0.0
        
        self.addSubview(screenshotCloseButton!)
    }
    
    func createAppIcon()
    {
        appIconImageView = UIImageView(frame: CGRectMake(appDescriptionCircleView!.center.x - appIconImageViewSize / 2, appDescriptionCircleView!.center.y - radius! - 130, appIconImageViewSize, appIconImageViewSize))
        appIconImageView?.layer.cornerRadius = appIconImageViewSize / 2
        appIconImageView?.layer.masksToBounds = true
        appIconImageView?.image = UIImage(named: "carambolecounterlogo")
        self.addSubview(appIconImageView!)
    }
    
    func createScreenshotsButton()
    {
        screenshotsButton = UIButton.buttonWithType(.System) as? UIButton
        screenshotsButton?.setTitle("Show Screenshots", forState: .Normal)
        screenshotsButton?.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        screenshotsButton?.titleLabel!.font = UIFont.boldSystemFontOfSize(17)
        screenshotsButton?.frame = CGRectMake(self.frame.size.width / 2 - screenshotsButtonSize / 2, appDescriptionCircleView!.frame.origin.y + appDescriptionCircleView!.frame.size.height + 30, screenshotsButtonSize, 30)
        screenshotsButton?.addTarget(self, action: "screenshotsButtonPressed:", forControlEvents: .TouchUpInside)
        
        self.addSubview(screenshotsButton!)
    }
    
    func createScreenshotDownButton()
    {
        screenshotDownButton = UIButton.buttonWithType(.System) as? UIButton
        screenshotDownButton?.frame = CGRectMake(self.frame.size.width / 2 - 15, appDescriptionCircleView!.frame.origin.y + appDescriptionCircleView!.frame.size.height + 60, 30, 30)
        screenshotDownButton?.addTarget(self, action: "screenshotsButtonPressed:", forControlEvents: .TouchUpInside)
        screenshotDownButton?.setBackgroundImage(UIImage(named: "arrowdownwardicon"), forState: .Normal)
        
        self.addSubview(screenshotDownButton!)
    }
    
    func createScreenshotNextPrevButtons()
    {
        nextScreenshotButton = UIButton.buttonWithType(.System) as? UIButton
        nextScreenshotButton?.frame = CGRectMake(screenshotImageViews[0].frame.origin.x + screenshotImageViews[0].frame.size.width + 10, screenshotsButton!.frame.origin.y + 70 + screenshotImageViews[0].frame.size.height / 2, 32, 32)
        nextScreenshotButton?.setBackgroundImage(UIImage(named: "rightbutton"), forState: .Normal)
        nextScreenshotButton?.addTarget(self, action: "nextScreenshotButtonPressed", forControlEvents: .TouchUpInside)
        nextScreenshotButton?.alpha = 0.0
        self.addSubview(nextScreenshotButton!)
        
        prevScreenshotButton = UIButton.buttonWithType(.System) as? UIButton
        prevScreenshotButton?.frame = CGRectMake(screenshotImageViews[0].frame.origin.x - 32 - 10, screenshotsButton!.frame.origin.y + 70 + screenshotImageViews[0].frame.size.height / 2, 32, 32)
        prevScreenshotButton?.setBackgroundImage(UIImage(named: "leftbutton"), forState: .Normal)
        prevScreenshotButton?.addTarget(self, action: "prevScreenshotButtonPressed", forControlEvents: .TouchUpInside)
        nextScreenshotButton?.alpha = 0.0
        self.addSubview(prevScreenshotButton!)
    }
    
    func createScreenshots()
    {
        let width: CGFloat = appDescriptionCircleView!.frame.size.width - 30
        let height: CGFloat = width * 1.775
        
        var offsetX: CGFloat = 0
        
        // create image views for all screenshots necessary
        for i in 0...2
        {
            let screenshotImageView = UIImageView(frame: CGRectMake(self.frame.size.width / 2 - width / 2 + offsetX, screenshotsButton!.frame.origin.y + 70, width, height))
            screenshotImageView.alpha = 0.0
            screenshotImageViews.append(screenshotImageView)
            offsetX += CGFloat(width + 100)
            
            self.addSubview(screenshotImageView)
        }
    }
    
    func screenshotsButtonPressed(button: UIButton)
    {
        doScreenshotTranslateAnimation(true)
        showScreenshot = !showScreenshot
    }
    
    func doScreenshotTranslateAnimation(animated: Bool)
    {
        UIView.animateWithDuration(animated ? 0.8 : 0.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            let screenHeight = UIScreen.mainScreen().bounds.size.height
            
            var offsetY = self.animationOffset!
            
            if self.showScreenshot
            {
                self.screenshotsButton?.setTitle("Show Screenshots", forState: .Normal)
                offsetY = CGFloat(-1) * offsetY
            }
            else
            {
                self.screenshotsButton?.setTitle("Back To App Info", forState: .Normal)
                self.screenshotDownButton?.hidden = true
                self.leftArrowButton?.hidden = true
                self.rightArrowButton?.hidden = true
            }
            
            self.screenshotsButton!.center = CGPointMake(self.screenshotsButton!.center.x, self.screenshotsButton!.center.y - offsetY)
            self.screenshotCloseButton!.center = CGPointMake(self.screenshotCloseButton!.center.x, self.screenshotCloseButton!.center.y - offsetY)
            self.appDescriptionCircleView!.center = CGPointMake(self.appDescriptionCircleView!.center.x, self.appDescriptionCircleView!.center.y - offsetY)
            self.closeButton!.center = CGPointMake(self.closeButton!.center.x, self.closeButton!.center.y - offsetY)
            self.appIconImageView!.center = CGPointMake(self.appIconImageView!.center.x, self.appIconImageView!.center.y - offsetY)
            self.nextScreenshotButton!.center = CGPointMake(self.nextScreenshotButton!.center.x, self.nextScreenshotButton!.center.y - offsetY)
            self.prevScreenshotButton!.center = CGPointMake(self.prevScreenshotButton!.center.x, self.prevScreenshotButton!.center.y - offsetY)
            
            // y-translate all screenshots (alpha 0.0 -> 1.0)
            for i in 0...self.screenshotImageViews.count - 1
            {
                self.screenshotImageViews[i].center = CGPointMake(self.screenshotImageViews[i].center.x, self.screenshotImageViews[i].center.y - offsetY)
            }
            
            if !self.showScreenshot
            {
                for i in 0...self.screenshotImageViews.count - 1
                {
                    self.screenshotImageViews[i].alpha = 1.0
                }
                self.screenshotCloseButton!.alpha = 1.0
                self.nextScreenshotButton!.alpha = 1.0
                self.prevScreenshotButton!.alpha = 1.0
            }
            else
            {
                for i in 0...self.screenshotImageViews.count - 1
                {
                    self.screenshotImageViews[i].alpha = 0.0
                }
                self.screenshotCloseButton!.alpha = 0.0
                self.nextScreenshotButton!.alpha = 0.0
                self.prevScreenshotButton!.alpha = 0.0
            }
        }) { (b: Bool) -> Void in
            if !self.showScreenshot
            {
                self.leftArrowButton?.hidden = false
                self.rightArrowButton?.hidden = false
                self.screenshotDownButton?.hidden = false
            }
        }
    }
    
    func createNavigationButtons()
    {
        let screenRect = UIScreen.mainScreen().bounds
        let screenWidth = screenRect.size.width
        let screenHeight = screenRect.size.height
        
        rightArrowButton = UIButton.buttonWithType(.System) as? UIButton
        rightArrowButton?.frame = CGRectMake(self.frame.size.width / 2 + radius! + 4, self.frame.size.height / 2 - 16, 32, 32)
        rightArrowButton?.setBackgroundImage(UIImage(named: "rightbutton"), forState: .Normal)
        rightArrowButton?.addTarget(self, action: "rightButtonPressed", forControlEvents: .TouchUpInside)
        self.addSubview(rightArrowButton!)
        
        leftArrowButton = UIButton.buttonWithType(.System) as? UIButton
        leftArrowButton?.frame = CGRectMake(self.frame.size.width / 2 - radius! - 4 - 32, self.frame.size.height / 2 - 16, 32, 32)
        leftArrowButton?.setBackgroundImage(UIImage(named: "leftbutton"), forState: .Normal)
        leftArrowButton?.addTarget(self, action: "leftButtonPressed", forControlEvents: .TouchUpInside)
        self.addSubview(leftArrowButton!)
    }

    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func closeButtonPressed(button: UIButton)
    {
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.transform = CGAffineTransformMakeScale(0.01, 0.01)
        }) { (b: Bool) -> Void in
            self.hidden = true
        
            if self.showScreenshot
            {
                self.doScreenshotTranslateAnimation(false)
                self.showScreenshot = !self.showScreenshot
            }
        NSNotificationCenter.defaultCenter().postNotificationName("com.codeup.WWDC2015Submission.AppDescriptionCloseAnimationFinished", object: nil)
        }
    }
    
    func nextScreenshotButtonPressed()
    {
        activeScreenshotIndex++
        updateScreenshotNavigationButtons()
        UIView.animateWithDuration(0.4, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            
            for i in 0...self.screenshotImageViews.count - 1
            {
                self.screenshotImageViews[i].transform = CGAffineTransformMakeTranslation(-self.screenshotImageViews[i].frame.size.width * CGFloat(self.activeScreenshotIndex) - 100 * CGFloat(self.activeScreenshotIndex), 0)
            }
            
        }, completion: nil)
    }
    
    func prevScreenshotButtonPressed()
    {
        activeScreenshotIndex--
        updateScreenshotNavigationButtons()
        UIView.animateWithDuration(0.4, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            
            for i in 0...self.screenshotImageViews.count - 1
            {
                self.screenshotImageViews[i].transform = CGAffineTransformMakeTranslation(-self.screenshotImageViews[i].frame.size.width * CGFloat(self.activeScreenshotIndex) - 100 * CGFloat(self.activeScreenshotIndex), 0)
            }
            
        }, completion: nil)
    }
    
    func rightButtonPressed()
    {
        activeAppIndex++
        appDescriptionCircleView!.setAppIndex(activeAppIndex)
        updateNavigationButtons()
    }
    
    func leftButtonPressed()
    {
        activeAppIndex--
        appDescriptionCircleView!.setAppIndex(activeAppIndex)
        updateNavigationButtons()
    }
    
    func leftSwipeDetected()
    {
        if !showScreenshot
        {
            if activeAppIndex == appsTitles.count - 1 { return }
            activeAppIndex++
            appDescriptionCircleView!.setAppIndex(activeAppIndex)
            updateNavigationButtons()
        }
        else
        {
            if activeScreenshotIndex != screenshotImageViews.count - 1 { nextScreenshotButtonPressed() }
        }
    }
    
    func rightSwipeDetected()
    {
        if !showScreenshot
        {
            if activeAppIndex == 0 { return }
            activeAppIndex--
            appDescriptionCircleView!.setAppIndex(activeAppIndex)
            updateNavigationButtons()
        }
        else
        {
            if activeScreenshotIndex != 0 { prevScreenshotButtonPressed() }
        }
    }
    
    func upSwipeDetected()
    {
        if showScreenshot { return }
        screenshotsButtonPressed(screenshotsButton!)
    }
    
    func setAppIndex(index: Int)
    {
        goBackToFirstScreenshot()
        updateScreenshotNavigationButtons()
        
        activeAppIndex = index
        appDescriptionCircleView!.setAppIndex(index)
        updateNavigationButtons()
    }
    
    func goBackToFirstScreenshot()
    {
        for i in 0...screenshotImageViews.count - 1
        {
            screenshotImageViews[i].transform = CGAffineTransformMakeTranslation(0, 0)
        }
        activeScreenshotIndex = 0
        updateNavigationButtons()
    }
    
    func updateNavigationButtons()
    {
        appIconImageView?.image = UIImage(named: appsLogos[activeAppIndex])
        
        // update the screenshots
        for i in 0...screenshotImageViews.count - 1
        {
            screenshotImageViews[i].image = UIImage(named: appsScreenshots[activeAppIndex][i])
        }
        
        if activeAppIndex == 0 { leftArrowButton?.hidden = true }
        else { leftArrowButton?.hidden = false }
        
        if activeAppIndex == appsTitles.count - 1 { rightArrowButton?.hidden = true }
        else { rightArrowButton?.hidden = false }
        
        if showScreenshot
        {
            leftArrowButton?.hidden = true
            rightArrowButton?.hidden = true
        }
    }
    
    func updateScreenshotNavigationButtons()
    {
        if activeScreenshotIndex == 0 { prevScreenshotButton?.hidden = true }
        else { prevScreenshotButton?.hidden = false }
        
        if activeScreenshotIndex == screenshotImageViews.count - 1 { nextScreenshotButton?.hidden = true }
        else { nextScreenshotButton?.hidden = false }
    }
}