//
//  InterestsViewController.swift
//  WWDC2015Submission
//
//  Created by Martijn de Vos on 20-04-15.
//  Copyright (c) 2015 CodeUp. All rights reserved.
//

import Foundation
import UIKit

class InterestsViewController: PageViewController
{
    @IBOutlet weak var snowboardPhotoButton: RotatingButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        snowboardPhotoButton.layer.cornerRadius = snowboardPhotoButton.frame.size.width / 2
        snowboardPhotoButton.layer.masksToBounds = true
    }
    
    @IBAction func twitterButtonPressed()
    {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://twitter.com/devos50")!)
    }
    
    @IBAction func linkedinButtonPressed()
    {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://www.linkedin.com/profile/view?id=147884453")!)
    }
    
    @IBAction func facebookButtonPressed()
    {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://www.facebook.com/martijn.devos1")!)
    }
}