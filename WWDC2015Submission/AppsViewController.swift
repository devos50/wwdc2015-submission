//
//  AppsViewController.swift
//  WWDC2015Submission
//
//  Created by Martijn de Vos on 18-04-15.
//  Copyright (c) 2015 CodeUp. All rights reserved.
//

import Foundation
import UIKit

let appsTitles = ["Edutoets", "NewLinQ", "Carambole Counter", "TUDirect", "Camuse"]
let appsLogos = ["edutoetslogo", "newlinqlogo", "carambolecounterlogo", "tulogo", "camuselogo"]
let appsDescriptions = ["Edutoets Admin makes it easy for teachers to create tests and make tests available for students. Students can make these tests using the Edutoets Afname app.", "NewLinQ is an app that allows you to connect and chat with other users. The app is invite-only and users can make a profile to show their specialities and tell other users about themselves.", "Keep track of your billiard score with the Carambole Counter app. Easily enter the amount of caramboles you scored during each round and generate a PDF file with an overview of the game when finished. The history of played games is saved.", "With the TUDirect app, students of the Delft University of Technology can easily get insight in their grades, courses and schedule. This app makes use of the TU Delft API that provides open data.", "Camuse is a company in Bergen op Zoom that rents camera material. Users can use the app to learn more and inquire about rented products."]

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
        appDescriptionView!.setAppIndex(button.tag - 200)
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