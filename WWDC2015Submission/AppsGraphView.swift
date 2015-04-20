//
//  AppsGraphView.swift
//  WWDC2015Submission
//
//  Created by Martijn de Vos on 19-04-15.
//  Copyright (c) 2015 CodeUp. All rights reserved.
//

import Foundation
import UIKit

enum GraphViewPosition
{
    case UpperLeft
    case UpperRight
    case LowerLeft
    case LowerRight
    case Center
}

class AppsGraphView: UIView
{
    let newlinqButtonSize: CGFloat = 50
    var nodes = [UIButton]()
    var originalNodesCenters = [CGPoint]()
    var shouldDisplayEdges = false
    
    override func drawRect(rect: CGRect)
    {
        super.drawRect(rect)
        
        let context = UIGraphicsGetCurrentContext()
        
        if nodes.count == 0 || !shouldDisplayEdges { return }
        
        let pageButtonSize = nodes[0].frame.size.width
        
        CGContextSetGrayStrokeColor(context, 0.3, 1.0)
        CGContextSetLineWidth(context, 0.6)
        
        CGContextMoveToPoint(context, nodes[0].frame.origin.x + pageButtonSize / 2, nodes[0].frame.origin.y + pageButtonSize / 2)
        
        for index in 1...nodes.count - 1
        {
            CGContextAddLineToPoint(context, nodes[index].frame.origin.x + pageButtonSize / 2, nodes[index].frame.origin.y + pageButtonSize / 2)
            CGContextMoveToPoint(context, nodes[0].frame.origin.x + pageButtonSize / 2, nodes[0].frame.origin.y + pageButtonSize / 2)
        }
        
        CGContextStrokePath(context)
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        self.backgroundColor = UIColor.whiteColor()
    }
    
    func createGraph()
    {
        createNode(.Center, backgroundImage: UIImage(named: "edutoetslogo")!, withBorder: false)
        UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.nodes.last!.alpha = 1.0
            }, completion: nil)
        
        createNode(.UpperLeft, backgroundImage: UIImage(named: "newlinqlogo")!, withBorder: true)
        UIView.animateWithDuration(0.3, delay: 0.2, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.nodes.last!.alpha = 1.0
        }, completion: nil)
        
        createNode(.UpperRight, backgroundImage: UIImage(named: "carambolecounterlogo")!, withBorder: false)
        UIView.animateWithDuration(0.3, delay: 0.4, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.nodes.last!.alpha = 1.0
        }, completion: nil)
        
        createNode(.LowerLeft, backgroundImage: UIImage(named: "tulogo")!, withBorder: false)
        UIView.animateWithDuration(0.3, delay: 0.6, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.nodes.last!.alpha = 1.0
        }, completion: nil)
        
        createNode(.LowerRight, backgroundImage: UIImage(named: "camuselogo")!, withBorder: true)
        UIView.animateWithDuration(0.3, delay: 0.8, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.nodes.last!.alpha = 1.0
        }) {
            (b: Bool) -> Void in
                self.shouldDisplayEdges = true
                self.setNeedsDisplay()
        }
    }
    
    func createNode(position: GraphViewPosition, backgroundImage: UIImage, withBorder: Bool)
    {
        let nodeButton = UIButton.buttonWithType(.System) as! UIButton
        
        var center = CGPointZero
        if position == .UpperLeft { center = CGPointMake(self.frame.size.width / 6, self.frame.size.height / 6) }
        if position == .UpperRight { center = CGPointMake(self.frame.size.width - self.frame.size.width / 6, self.frame.size.height / 6) }
        if position == .LowerLeft { center = CGPointMake(self.frame.size.width / 6, self.frame.size.height - self.frame.size.height / 6) }
        if position == .LowerRight { center = CGPointMake(self.frame.size.width - self.frame.size.width / 6, self.frame.size.height - self.frame.size.height / 6) }
        if position == .Center { center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2) }
        
        nodeButton.frame = CGRectMake(center.x - newlinqButtonSize / 2, center.y - newlinqButtonSize / 2, newlinqButtonSize, newlinqButtonSize)
        nodeButton.setBackgroundImage(backgroundImage, forState: .Normal)
        nodeButton.backgroundColor = UIColor.whiteColor()
        
        nodeButton.layer.cornerRadius = nodeButton.frame.size.width / 2
        nodeButton.layer.masksToBounds = true
        if withBorder
        {
            nodeButton.layer.borderColor = UIColor.blackColor().CGColor
            nodeButton.layer.borderWidth = 0.5
        }
        
        nodeButton.alpha = 0.0
        nodes.append(nodeButton)
        originalNodesCenters.append(center)
        
        self.addSubview(nodeButton)
    }
    
    func startMovingToCenter()
    {
        UIView.animateWithDuration(0.4, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            
            self.shouldDisplayEdges = false
            self.setNeedsDisplay()
            for index in 1...self.nodes.count - 1
            {
                self.nodes[index].center = self.nodes[0].center
            }
            
        }) { (b: Bool) -> Void in
            self.shrinkNodes()
        }
    }
    
    func shrinkNodes()
    {
        UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            
            for index in 0...self.nodes.count - 1
            {
                self.nodes[index].transform = CGAffineTransformMakeScale(0.01, 0.01)
            }
            
        }) { (b: Bool) -> Void in
            NSNotificationCenter.defaultCenter().postNotificationName("com.codeup.WWDC2015Submission.AppsGraphAnimationFinished", object: nil)
        }
    }
    
    func growNodes()
    {
        UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            
            for index in 0...self.nodes.count - 1
            {
                self.nodes[index].transform = CGAffineTransformMakeScale(1, 1)
            }
        
        }) { (b: Bool) -> Void in
            self.startMovingToOriginalCenters()
        }
    }
    
    func startMovingToOriginalCenters()
    {
        UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            
            for index in 0...self.nodes.count - 1
            {
                self.nodes[index].center = self.originalNodesCenters[index]
            }
            
        }) { (b: Bool) -> Void in
            self.shouldDisplayEdges = true
            self.setNeedsDisplay()
        }
    }
}