//
//  RotatingButton.swift
//  WWDC2015Submission
//
//  Created by Martijn de Vos on 19-04-15.
//  Copyright (c) 2015 CodeUp. All rights reserved.
//

import Foundation
import UIKit

class RotatingButton: UIButton
{
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        self.addTarget(self, action: "buttonPressed", forControlEvents: .TouchUpInside)
    }
    
    func buttonPressed()
    {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.transform = CGAffineTransformMakeScale(1.1, 1.1)
        }) { (b: Bool) -> Void in
            self.shrinkButton()
        }
    }
    
    func shrinkButton()
    {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.transform = CGAffineTransformMakeScale(1.0, 1.0)
        })
    }
}