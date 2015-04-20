//
//  SpecialityCircleView.swift
//  WWDC2015Submission
//
//  Created by Martijn de Vos on 20-04-15.
//  Copyright (c) 2015 CodeUp. All rights reserved.
//

import Foundation
import UIKit

class SpecialityCircleView: UIView
{
    var titleLabel: UILabel?
    var textLabel: UILabel?
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        createTitleLabel()
        createTextLabel()
    }
    
    func createTitleLabel()
    {
        titleLabel = UILabel(frame: CGRectMake(0, 30, self.frame.size.width, 20))
        titleLabel?.text = "Carambole Counter"
        titleLabel?.textAlignment = .Center
        titleLabel?.font = UIFont(name: "Novecentowide-DemiBold", size: 16)
        
        self.addSubview(titleLabel!)
    }
    
    func createTextLabel()
    {
        let textLabelSize = self.frame.size.width / 2 / sqrt(2) - 10
        textLabel = UILabel(frame: CGRectMake(self.frame.size.width / 2 - textLabelSize, self.frame.size.height / 2 - textLabelSize, textLabelSize * 2, textLabelSize * 2))
        textLabel?.numberOfLines = 0
        textLabel?.lineBreakMode = .ByWordWrapping
        textLabel?.textAlignment = .Center
        textLabel?.font = UIFont.systemFontOfSize(15)
        textLabel?.text = "With the Carambole Counter, you can easily keep track of your billiard score."
        
        self.addSubview(textLabel!)
    }
    
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setInfo(title: String, specialityDescription: String)
    {
        titleLabel?.text = title
        textLabel?.text = specialityDescription
    }
}