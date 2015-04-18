//
//  MenuButton.swift
//  WWDC2015Submission
//
//  Created by Martijn de Vos on 18-04-15.
//  Copyright (c) 2015 CodeUp. All rights reserved.
//

import Foundation
import UIKit

class MenuButton: UIButton
{
    var originalCenter: CGPoint?
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    func startButtonAnimation()
    {
        // animate the button to the center of the screen
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.transform = CGAffineTransformMakeScale(0.1, 0.1)
            let screenRect = UIScreen.mainScreen().bounds
            self.center = CGPointMake(screenRect.width / 2, screenRect.height / 2)
            }) { (b: Bool) -> Void in
                NSNotificationCenter.defaultCenter().postNotificationName("com.codeup.WWDC2015Submission.MenuButtonAnimationFinished", object: nil)
        }
    }
    
    func restoreToOriginalPosition()
    {
        // animate the button to its original position
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.transform = CGAffineTransformMakeScale(1, 1)
            let screenRect = UIScreen.mainScreen().bounds
            self.center = self.originalCenter!
            }) { (b: Bool) -> Void in
                // NSNotificationCenter.defaultCenter().postNotificationName("com.codeup.WWDC2015Submission.MenuButtonAnimationFinished", object: nil)
        }
    }
}