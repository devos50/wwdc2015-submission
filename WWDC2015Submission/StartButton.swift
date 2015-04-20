//
//  StartButton.swift
//  WWDC2015Submission
//
//  Created by Martijn de Vos on 4/18/15.
//  Copyright (c) 2015 CodeUp. All rights reserved.
//

import Foundation
import UIKit

class StartButton: UIButton
{
    var destination: CGPoint?
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = self.frame.size.width / 2
        self.layer.masksToBounds = true
    }
    
    private func performGrowAnimation()
    {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.transform = CGAffineTransformMakeScale(1.1, 1.1)
            }) { (b: Bool) -> Void in
                self.performShrinkAnimation()
        }
    }
    
    private func performShrinkAnimation()
    {
        self.setTitle("", forState: .Normal)
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.transform = CGAffineTransformMakeScale(0.1, 0.1)
            }) { (b: Bool) -> Void in
                self.moveToDestination()
        }
    }
    
    private func moveToDestination()
    {
        UIView.animateWithDuration(0.6, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.center = self.destination!
        }) { (b: Bool) -> Void in
            NSNotificationCenter.defaultCenter().postNotificationName("com.codeup.WWDC2015Submission.StartButtonAnimationFinished", object: nil)
        }
    }
    
    func startButtonAnimation(destination: CGPoint)
    {
        self.destination = destination
        performGrowAnimation()
    }
}