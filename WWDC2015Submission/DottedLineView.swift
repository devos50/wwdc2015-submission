//
//  DottedLineView.swift
//  WWDC2015Submission
//
//  Created by Martijn de Vos on 4/18/15.
//  Copyright (c) 2015 CodeUp. All rights reserved.
//

import Foundation
import UIKit

class DottedLineView: UIView
{
    override func drawRect(rect: CGRect)
    {
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 10.0)
        CGContextSetStrokeColorWithColor(context, UIColor.lightGrayColor().CGColor)
        let dashArray:[CGFloat] = [0.0, 25.0]
        CGContextSetLineCap(context, kCGLineCapRound)
        CGContextSetLineDash(context, 0.0, dashArray, 2)
        CGContextMoveToPoint(context, self.frame.size.width / 2, 10)
        CGContextAddLineToPoint(context, self.frame.size.width / 2, self.frame.size.height)
        CGContextStrokePath(context)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clearColor()
    }
}