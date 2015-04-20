//
//  SpecialityView.swift
//  WWDC2015Submission
//
//  Created by Martijn de Vos on 20-04-15.
//  Copyright (c) 2015 CodeUp. All rights reserved.
//

import Foundation
import UIKit

class SpecialityView: UIView
{
    var specialityCircleView: SpecialityCircleView?
    var closeButton: UIButton?
    
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
        let radius = screenWidth * 0.4
        specialityCircleView = SpecialityCircleView(frame: CGRectMake(self.frame.size.width / 2 - radius, self.frame.size.height / 2 - radius, radius * 2, radius * 2))
        specialityCircleView?.backgroundColor = UIColor.whiteColor()
        specialityCircleView?.layer.cornerRadius = radius
        specialityCircleView?.layer.masksToBounds = true
        
        self.addSubview(specialityCircleView!)
        createCloseButton(radius)
        
        self.transform = CGAffineTransformMakeScale(0.01, 0.01)
    }
    
    func createCloseButton(radius: CGFloat)
    {
        closeButton = CloseButton.getCloseButton()
        closeButton?.frame = CGRectMake(specialityCircleView!.center.x - radius / sqrt(2) - 20, specialityCircleView!.center.y - radius / sqrt(2) - 20, 30, 30)
        closeButton?.addTarget(self, action: "closeButtonPressed:", forControlEvents: .TouchUpInside)
        
        self.addSubview(closeButton!)
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
                NSNotificationCenter.defaultCenter().postNotificationName("com.codeup.WWDC2015Submission.SpecialityViewCloseAnimationFinished", object: nil)
        }
    }
}