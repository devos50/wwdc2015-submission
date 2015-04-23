//
//  AppDescriptionCircleView.swift
//  WWDC2015Submission
//
//  Created by Martijn de Vos on 19-04-15.
//  Copyright (c) 2015 CodeUp. All rights reserved.
//

import Foundation
import UIKit

class AppDescriptionCircleView: UIView
{
    var titleLabel: UILabel?
    var textLabel: UILabel?
    var websiteButton: UIButton?
    var activeAppIndex: Int = 0
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        createTitleLabel()
        createTextLabel()
        createWebsiteButton()
    }
    
    func createTitleLabel()
    {
        titleLabel = UILabel(frame: CGRectMake(0, 22, self.frame.size.width, 20))
        titleLabel?.text = "Carambole Counter"
        titleLabel?.textAlignment = .Center
        titleLabel?.font = UIFont(name: "Novecentowide-DemiBold", size: 16)
        
        self.addSubview(titleLabel!)
    }
    
    func createTextLabel()
    {
        let textLabelSize = self.frame.size.width / 2 / sqrt(2) - 5
        textLabel = UILabel(frame: CGRectMake(self.frame.size.width / 2 - textLabelSize, self.frame.size.height / 2 - textLabelSize, textLabelSize * 2, textLabelSize * 2))
        textLabel?.numberOfLines = 0
        textLabel?.lineBreakMode = .ByWordWrapping
        textLabel?.textAlignment = .Center
        textLabel?.font = UIFont.systemFontOfSize(13)
        textLabel?.text = "With the Carambole Counter, you can easily keep track of your billiard score."
        
        self.addSubview(textLabel!)
    }
    
    func createWebsiteButton()
    {
        let buttonSize = self.frame.size.width / 2 / sqrt(2)
        websiteButton = UIButton.buttonWithType(.System) as? UIButton
        websiteButton?.frame = CGRectMake(self.frame.size.width / 2 - buttonSize / 2, self.frame.size.height - 43, buttonSize, 25)
        websiteButton?.setTitle("Visit Website", forState: .Normal)
        websiteButton?.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        websiteButton?.titleLabel?.font = UIFont(name: "LucidaGrande", size: 13)
        websiteButton?.addTarget(self, action: "websiteButtonPressed", forControlEvents: .TouchUpInside)
        
        self.addSubview(websiteButton!)
    }
    
    func setAppIndex(index: Int)
    {
        activeAppIndex = index
        titleLabel?.text = appsTitles[index]
        textLabel?.text = appsDescriptions[index]
        if appsWebsites[index] == "" { self.websiteButton!.hidden = true }
        else { self.websiteButton?.hidden = false }
    }
    
    func websiteButtonPressed()
    {
        UIApplication.sharedApplication().openURL(NSURL(string: appsWebsites[activeAppIndex])!)
    }

    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}