//
//  MenuView.swift
//  WWDC2015Submission
//
//  Created by Martijn de Vos on 18-04-15.
//  Copyright (c) 2015 CodeUp. All rights reserved.
//

import Foundation
import UIKit

enum PageButtonLocation: Int {
    case Top = 0
    case Right = 1
    case Bottom = 2
    case Left = 3
}

class MenuView: UIView
{
    var menuSubView: MenuSubView?
    let pageButtonSize: CGFloat = 60
    let pageButtonCirclePadding: CGFloat = 10
    var pressedButtonTag: Int?
    
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
        menuSubView = MenuSubView(frame: CGRectMake(self.frame.size.width / 2 - radius, self.frame.size.height / 2 - radius, radius * 2, radius * 2))
        menuSubView?.backgroundColor = UIColor.whiteColor()
        menuSubView?.layer.cornerRadius = radius
        menuSubView?.layer.masksToBounds = true
        
        self.addSubview(menuSubView!)
        
        createCloseButton(radius)
        createPageButton(.Top, backgroundColor: UIColor(rgba: "#6EB339"), backgroundImage: UIImage(named: "profileicon")!, tag: 101)
        createPageButton(.Right, backgroundColor: UIColor(rgba: "#43A2D1"), backgroundImage: UIImage(named: "apppageicon")!, tag: 102)
        createPageButton(.Bottom, backgroundColor: UIColor(rgba: "#DE8F35"), backgroundImage: UIImage(named: "companyicon")!, tag: 103)
        createPageButton(.Left, backgroundColor: UIColor(rgba: "#CA2CAB"), backgroundImage: UIImage(named: "snowboardicon")!, tag: 104)
        
        self.transform = CGAffineTransformMakeScale(0.01, 0.01)
    }
    
    func createCloseButton(radius: CGFloat)
    {
        let closeButton = CloseButton.getCloseButton()
        closeButton.frame = CGRectMake(menuSubView!.center.x - radius / sqrt(2) - 20, menuSubView!.center.y - radius / sqrt(2) - 20, 30, 30)
        closeButton.addTarget(self, action: "closeButtonPressed:", forControlEvents: .TouchUpInside)
        
        self.addSubview(closeButton)
    }
    
    func createPageButton(position: PageButtonLocation, backgroundColor: UIColor, backgroundImage: UIImage, tag: Int)
    {
        let subViewRadius = menuSubView!.frame.size.width / 2
        let dx = [-pageButtonSize / 2, subViewRadius - pageButtonSize - pageButtonCirclePadding, -pageButtonSize / 2, -subViewRadius + pageButtonCirclePadding]
        let dy = [-subViewRadius + pageButtonCirclePadding, -pageButtonSize / 2, subViewRadius - pageButtonSize - pageButtonCirclePadding, -pageButtonSize / 2]
        
        let pageButton = UIButton.buttonWithType(.System) as UIButton
        pageButton.frame = CGRectMake(menuSubView!.frame.size.width / 2 + dx[position.rawValue], menuSubView!.frame.size.height / 2 + dy[position.rawValue], pageButtonSize, pageButtonSize)
        pageButton.backgroundColor = UIColor.blackColor()
        pageButton.layer.cornerRadius = pageButtonSize / 2
        pageButton.backgroundColor = backgroundColor
        pageButton.layer.masksToBounds = true
        pageButton.alpha = 0.0
        pageButton.tag = tag
        pageButton.addTarget(self, action: "menuButtonPressed:", forControlEvents: .TouchUpInside)
        
        pageButton.setBackgroundImage(backgroundImage, forState: .Normal)
        menuSubView?.addPageButton(pageButton)
        
        menuSubView?.addSubview(pageButton)
    }
    
    func closeButtonPressed(button: UIButton)
    {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.transform = CGAffineTransformMakeScale(0.01, 0.01)
        }) { (b: Bool) -> Void in
            self.hidden = true
                
            // we should set the alpha of the buttons in the subview to 0.0 again
            self.menuSubView?.hideAllPageButtons()
            self.menuSubView?.shouldDisplayEdges = false
            self.menuSubView?.setNeedsDisplay()
                
            NSNotificationCenter.defaultCenter().postNotificationName("com.codeup.WWDC2015Submission.MenuCloseAnimationFinished", object: nil)
        }
    }
    
    func menuButtonPressed(button: UIButton)
    {
        pressedButtonTag = button.tag
        
        // move the buttons to the center
        menuSubView?.shouldDisplayEdges = false
        menuSubView?.setNeedsDisplay()
        
        UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            
            for index in 0...self.menuSubView!.pageButtons.count - 1
            {
                self.menuSubView!.pageButtons[index].center = CGPointMake(self.menuSubView!.frame.size.width / 2, self.menuSubView!.frame.size.height / 2)
            }
            
        }) { (b: Bool) -> Void in
            self.shrinkAndHideMenu()
        }
    }
    
    func shrinkAndHideMenu()
    {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.transform = CGAffineTransformMakeScale(0.01, 0.01)
        }) { (b: Bool) -> Void in
            self.hidden = true
            
            var identifier = "AboutViewController"
            if self.pressedButtonTag == 102 { identifier = "AppsViewController" }
            else if self.pressedButtonTag == 103 { identifier = "SpecialitiesViewController" }
            else if self.pressedButtonTag == 104 { identifier = "InterestsViewController" }
            
            NSNotificationCenter.defaultCenter().postNotificationName("com.codeup.WWDC2015Submission.ShouldOpenPage", object: nil, userInfo: ["page" : identifier])
        }
    }
    
    func fadePageButtons()
    {
        menuSubView?.fadePageButtons()
    }

    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
}