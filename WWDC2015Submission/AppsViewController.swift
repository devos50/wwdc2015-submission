//
//  AppsViewController.swift
//  WWDC2015Submission
//
//  Created by Martijn de Vos on 18-04-15.
//  Copyright (c) 2015 CodeUp. All rights reserved.
//

import Foundation
import UIKit

class AppsViewController: PageViewController
{
    @IBOutlet weak var appsButton: RotatingButton!
    @IBOutlet weak var companyButton: UIButton!
    @IBOutlet weak var appsGraphView: AppsGraphView!
    private var appDescriptionView: AppDescriptionView?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        appsButton.layer.cornerRadius = appsButton.frame.size.width / 2
        appsButton.layer.masksToBounds = true
        
        companyButton.layer.cornerRadius = companyButton.frame.size.width / 2
        companyButton.layer.masksToBounds = true
        
        // add the app description view
        let screenRect = UIScreen.mainScreen().bounds
        let screenWidth = screenRect.size.width
        let screenHeight = screenRect.size.height
        let hypothenusa = sqrt((screenWidth / 2) * (screenWidth / 2) + (screenHeight / 2) * (screenHeight / 2))
        
        appDescriptionView = AppDescriptionView(frame: CGRectMake(screenWidth / 2 - hypothenusa, screenHeight / 2 - hypothenusa, hypothenusa * 2, hypothenusa * 2))
        self.view.addSubview(appDescriptionView!)
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        // start listening to animation finished notifications
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "appsGraphAnimationFinished:", name: "com.codeup.WWDC2015Submission.AppsGraphAnimationFinished", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "appDescriptionCloseAnimationFinished:", name: "com.codeup.WWDC2015Submission.AppDescriptionCloseAnimationFinished", object: nil)
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        super.viewWillDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "com.codeup.WWDC2015Submission.AppsGraphAnimationFinished", object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "com.codeup.WWDC2015Submission.AppDescriptionCloseAnimationFinished", object: nil)
    }
    
    func nodeButtonPressed(button: UIButton)
    {
        appsGraphView.startMovingToCenter()
    }
    
    func appsGraphAnimationFinished(notification: NSNotification)
    {
        appDescriptionView?.hidden = false
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            appDescriptionView?.transform = CGAffineTransformMakeScale(1, 1)
        }) { (b: Bool) -> Void in
                // ...
        }
    }
    
    func appDescriptionCloseAnimationFinished(notification: NSNotification)
    {
        appsGraphView.growNodes()
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        appsGraphView.createGraph()
        
        // set the on click targets
        for index in 0...appsGraphView.nodes.count - 1
        {
            let nodeButton = appsGraphView.nodes[index]
            nodeButton.addTarget(self, action: "nodeButtonPressed:", forControlEvents: .TouchUpInside)
        }
    }
    
    @IBAction func specialitiesButtonPressed(button: UIButton)
    {
        self.performSegueWithIdentifier("SpecialitiesSegue", sender: self)
    }
}