//
//  MenuSubView.swift
//  WWDC2015Submission
//
//  Created by Martijn de Vos on 18-04-15.
//  Copyright (c) 2015 CodeUp. All rights reserved.
//

import Foundation
import UIKit

class MenuSubView: UIView
{
    var pageButtons = [UIButton]()
    var shouldDisplayEdges = false
    
    override func drawRect(rect: CGRect)
    {
        super.drawRect(rect)
        
        let context = UIGraphicsGetCurrentContext()
        
        if pageButtons.count == 0 || !shouldDisplayEdges { return }
        
        let pageButtonSize = pageButtons[0].frame.size.width
        
        CGContextSetGrayStrokeColor(context, 0.6, 1.0)
        CGContextSetLineWidth(context, 1.0)
        
        CGContextMoveToPoint(context, pageButtons[0].frame.origin.x + pageButtonSize / 2, pageButtons[0].frame.origin.y + pageButtonSize / 2)
        
        for index in 1...pageButtons.count
        {
            CGContextAddLineToPoint(context, pageButtons[index % pageButtons.count].frame.origin.x + pageButtonSize / 2, pageButtons[index % pageButtons.count].frame.origin.y + pageButtonSize / 2)
        }
        
        CGContextStrokePath(context)
    }
    
    func addPageButton(pageButton: UIButton)
    {
        self.pageButtons.append(pageButton)
    }
    
    func hideAllPageButtons()
    {
        for index in 0...pageButtons.count - 1
        {
            pageButtons[index].alpha = 0.0
        }
    }
    
    func fadePageButtons()
    {
        for index in 0...pageButtons.count - 1
        {
            let delay = 0.15 * Double(index)
            UIView.animateWithDuration(0.3, delay: delay, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                self.pageButtons[index].alpha = 1.0
                }) { (b: Bool) -> Void in
                    if index == self.pageButtons.count - 1
                    {
                        self.shouldDisplayEdges = true
                        self.setNeedsDisplay()
                    }
            }
        }
    }
}