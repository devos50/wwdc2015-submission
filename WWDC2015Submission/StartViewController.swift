//
//  ViewController.swift
//  WWDC2014Submission
//
//  Created by Martijn de Vos on 4/18/15.
//  Copyright (c) 2015 CodeUp. All rights reserved.
//

import UIKit

class StartViewController: UIViewController
{
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var startButton: StartButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // start listening to animation finished notifications
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "animationFinished:", name: "com.codeup.WWDC2015Submission.StartButtonAnimationFinished", object: nil)
        
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.layer.masksToBounds = true
    }
    
    func animationFinished(notification: NSNotification)
    {
        self.performSegueWithIdentifier("AboutSegue", sender: self)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startButtonPressed(sender: UIButton)
    {
        startButton.startButtonAnimation(profileImageView.center)
    }


}

