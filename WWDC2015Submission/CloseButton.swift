//
//  CloseButton.swift
//  WWDC2015Submission
//
//  Created by Martijn de Vos on 19-04-15.
//  Copyright (c) 2015 CodeUp. All rights reserved.
//

import Foundation
import UIKit

class CloseButton: UIButton
{
    class func getCloseButton() -> CloseButton
    {
        let closeButton = CloseButton.buttonWithType(.System) as! CloseButton
        
        closeButton.backgroundColor = UIColor.blackColor()
        closeButton.titleLabel?.font = UIFont.systemFontOfSize(19)
        closeButton.setTitle("×", forState: .Normal)
        closeButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        closeButton.layer.cornerRadius = 15
        closeButton.layer.masksToBounds = true
        
        return closeButton
    }
}