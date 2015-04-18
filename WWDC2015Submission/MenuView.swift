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
        createPageButton(.Top, backgroundColor: UIColor(rgba: "#6EB339"), backgroundImage: UIImage(named: "profileicon")!)
        createPageButton(.Right, backgroundColor: UIColor(rgba: "#43A2D1"), backgroundImage: UIImage(named: "apppageicon")!)
        createPageButton(.Bottom, backgroundColor: UIColor(rgba: "#CA2CAB"), backgroundImage: UIImage(named: "snowboardicon")!)
        createPageButton(.Left, backgroundColor: UIColor(rgba: "#DE8F35"), backgroundImage: UIImage(named: "companyicon")!)
        
        self.transform = CGAffineTransformMakeScale(0.01, 0.01)
    }
    
    func createCloseButton(radius: CGFloat)
    {
        let closeButton = UIButton.buttonWithType(.System) as! UIButton
        closeButton.frame = CGRectMake(menuSubView!.center.x - radius / sqrt(2) - 20, menuSubView!.center.y - radius / sqrt(2) - 20, 30, 30)
        closeButton.backgroundColor = UIColor.blackColor()
        closeButton.titleLabel?.font = UIFont.systemFontOfSize(19)
        closeButton.setTitle("×", forState: .Normal)
        closeButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        closeButton.layer.cornerRadius = 15
        closeButton.layer.masksToBounds = true
        
        self.addSubview(closeButton)
    }
    
    func createPageButton(position: PageButtonLocation, backgroundColor: UIColor, backgroundImage: UIImage)
    {
        let subViewRadius = menuSubView!.frame.size.width / 2
        let dx = [-pageButtonSize / 2, subViewRadius - pageButtonSize - pageButtonCirclePadding, -pageButtonSize / 2, -subViewRadius + pageButtonCirclePadding]
        let dy = [-subViewRadius + pageButtonCirclePadding, -pageButtonSize / 2, subViewRadius - pageButtonSize - pageButtonCirclePadding, -pageButtonSize / 2]
        
        let pageButton = UIButton.buttonWithType(.System) as! UIButton
        pageButton.frame = CGRectMake(menuSubView!.frame.size.width / 2 + dx[position.rawValue], menuSubView!.frame.size.height / 2 + dy[position.rawValue], pageButtonSize, pageButtonSize)
        pageButton.backgroundColor = UIColor.blackColor()
        pageButton.layer.cornerRadius = pageButtonSize / 2
        pageButton.backgroundColor = backgroundColor
        pageButton.layer.masksToBounds = true
        pageButton.alpha = 0.0
        
        pageButton.setBackgroundImage(backgroundImage, forState: .Normal)
        menuSubView?.addPageButton(pageButton)
        
        menuSubView?.addSubview(pageButton)
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