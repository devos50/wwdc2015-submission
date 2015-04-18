//
//  AboutViewController.swift
//  WWDC2015Submission
//
//  Created by Martijn de Vos on 4/18/15.
//  Copyright (c) 2015 CodeUp. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController
{
    @IBOutlet weak var menuButton: MenuButton!
    @IBOutlet weak var photoImageView: UIImageView!
    private var menuView: MenuView?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // start listening to animation finished notifications
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "menuAnimationFinished:", name: "com.codeup.WWDC2015Submission.MenuButtonAnimationFinished", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "menuCloseAnimationFinished:", name: "com.codeup.WWDC2015Submission.MenuCloseAnimationFinished", object: nil)
        
        // add the menu view - first find out the size of our transparent menu view with the Pythagoream theorem
        let screenRect = UIScreen.mainScreen().bounds
        let screenWidth = screenRect.size.width
        let screenHeight = screenRect.size.height
        let hypothenusa = sqrt((screenWidth / 2) * (screenWidth / 2) + (screenHeight / 2) * (screenHeight / 2))
        
        menuView = MenuView(frame: CGRectMake(screenWidth / 2 - hypothenusa, screenHeight / 2 - hypothenusa, hypothenusa * 2, hypothenusa * 2))
        self.view.addSubview(menuView!)
        
        photoImageView.layer.cornerRadius = photoImageView.frame.size.width / 2
        photoImageView.layer.masksToBounds = true
    }
    
    func menuAnimationFinished(notification: NSNotification)
    {
        menuButton.hidden = true
        menuView?.hidden = false
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            menuView?.transform = CGAffineTransformMakeScale(1, 1)
        }) { (b: Bool) -> Void in
                menuView?.fadePageButtons()
        }
    }
    
    func menuCloseAnimationFinished(notification: NSNotification)
    {
        menuButton.hidden = false
        menuButton.restoreToOriginalPosition()
    }
    
    @IBAction func menuButtonPressed(sender: UIButton)
    {
        menuButton.startButtonAnimation()
    }
}
