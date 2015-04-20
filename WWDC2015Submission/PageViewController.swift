//
//  PageViewController.swift
//  WWDC2015Submission
//
//  Created by Martijn de Vos on 18-04-15.
//  Copyright (c) 2015 CodeUp. All rights reserved.
//

import Foundation
import UIKit

class PageViewController: UIViewController
{
    let menuButtonSize: CGFloat = 40
    private var menuButton: MenuButton?
    var menuView: MenuView?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // add the menu view - first find out the size of our transparent menu view with the Pythagoream theorem
        let screenRect = UIScreen.mainScreen().bounds
        let screenWidth = screenRect.size.width
        let screenHeight = screenRect.size.height
        let hypothenusa = sqrt((screenWidth / 2) * (screenWidth / 2) + (screenHeight / 2) * (screenHeight / 2))
        
        menuView = MenuView(frame: CGRectMake(screenWidth / 2 - hypothenusa, screenHeight / 2 - hypothenusa, hypothenusa * 2, hypothenusa * 2))
        self.view.addSubview(menuView!)
        
        // create the menu button in the upper left corner
        menuButton = MenuButton.buttonWithType(.System) as? MenuButton
        menuButton?.frame = CGRectMake(10, 30, 40, 40)
        menuButton?.backgroundColor = UIColor(red: 119.0/255.0, green: 113.0/255.0, blue: 110.0/255.0, alpha: 0.8)
        menuButton?.setBackgroundImage(UIImage(named: "menu"), forState: .Normal)
        menuButton?.addTarget(self, action: "menuButtonPressed:", forControlEvents: .TouchUpInside)
        
        menuButton?.layer.cornerRadius = menuButtonSize / 2
        menuButton?.layer.masksToBounds = true
        menuButton?.originalCenter = CGPointMake(CGRectGetMidX(menuButton!.frame), CGRectGetMidY(menuButton!.frame))
        
        self.view.addSubview(menuButton!)
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        // start listening to animation finished notifications
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "menuAnimationFinished:", name: "com.codeup.WWDC2015Submission.MenuButtonAnimationFinished", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "menuCloseAnimationFinished:", name: "com.codeup.WWDC2015Submission.MenuCloseAnimationFinished", object: nil)
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        super.viewWillDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "com.codeup.WWDC2015Submission.MenuButtonAnimationFinished", object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "com.codeup.WWDC2015Submission.MenuCloseAnimationFinished", object: nil)
    }
    
    func menuAnimationFinished(notification: NSNotification)
    {
        menuButton?.hidden = true
        menuView?.hidden = false
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            menuView?.transform = CGAffineTransformMakeScale(1, 1)
            }) { (b: Bool) -> Void in
                menuView?.fadePageButtons()
        }
    }
    
    func menuCloseAnimationFinished(notification: NSNotification)
    {
        menuButton?.hidden = false
        menuButton?.restoreToOriginalPosition()
    }
    
    func menuButtonPressed(sender: UIButton)
    {
        menuButton?.startButtonAnimation()
    }
}