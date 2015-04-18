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
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = self.frame.size.width / 2
        self.layer.masksToBounds = true
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
}