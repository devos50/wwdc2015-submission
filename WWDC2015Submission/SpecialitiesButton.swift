//
//  SpecialitiesButton.swift
//  WWDC2015Submission
//
//  Created by Martijn de Vos on 20-04-15.
//  Copyright (c) 2015 CodeUp. All rights reserved.
//

import Foundation
import UIKit

class SpecialitiesButton: UIButton
{
    var originalTitle: String = ""
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
}