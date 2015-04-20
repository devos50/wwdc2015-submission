//
//  SpecialitiesViewController.swift
//  WWDC2015Submission
//
//  Created by Martijn de Vos on 19-04-15.
//  Copyright (c) 2015 CodeUp. All rights reserved.
//

import Foundation
import UIKit

class SpecialitiesViewController: PageViewController
{
    @IBOutlet weak var specialitiesButton: RotatingButton!
    @IBOutlet weak var softwareEngineeringLabel: UILabel!
    @IBOutlet weak var interestsButton: UIButton!
    private var specialityView: SpecialityView?
    
    let titles = ["Own Company", "iOS Development", "Web Development", "Backends", "Swift", "Objective-C", "Java", "PHP", "C++"]
    let originalWidths: [CGFloat] = [119, 140, 140, 85, 56, 100, 56, 56, 56]
    var specialityButtons = [SpecialitiesButton]()
    var currentlySelectedButton: SpecialitiesButton?
    var oldButtonPosition: CGPoint?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let screenRect = UIScreen.mainScreen().bounds
        let screenWidth = screenRect.size.width
        let screenHeight = screenRect.size.height
        
        specialitiesButton.layer.cornerRadius = specialitiesButton.frame.size.width / 2
        specialitiesButton.layer.masksToBounds = true
        
        interestsButton.layer.cornerRadius = interestsButton.frame.size.width / 2
        interestsButton.layer.masksToBounds = true
        
        var y: CGFloat = softwareEngineeringLabel.frame.origin.y + 60
        for index in 0...3
        {
            addSpecialitiesButton(titles[index], x: 16, y: y, index: index)
            y += 45
        }
        
        y = softwareEngineeringLabel.frame.origin.y + 60
        for index in 4...titles.count - 1
        {
            addSpecialitiesButton(titles[index], x: screenWidth - 16 - 25, y: y, index: index)
            y += 45
        }
        
        // add the speciality view
        let hypothenusa = sqrt((screenWidth / 2) * (screenWidth / 2) + (screenHeight / 2) * (screenHeight / 2))
        
        specialityView = SpecialityView(frame: CGRectMake(screenWidth / 2 - hypothenusa, screenHeight / 2 - hypothenusa, hypothenusa * 2, hypothenusa * 2))
        self.view.addSubview(specialityView!)
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "specialityViewCloseAnimationFinished:", name: "com.codeup.WWDC2015Submission.SpecialityViewCloseAnimationFinished", object: nil)
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        super.viewWillDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "com.codeup.WWDC2015Submission.SpecialityViewCloseAnimationFinished", object: nil)
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        
        for index in 0...3
        {
            UIView.animateWithDuration(0.4, delay: Double(index) * 0.15, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                let curFrame = self.specialityButtons[index].frame
                self.specialityButtons[index].frame = CGRectMake(curFrame.origin.x, curFrame.origin.y, self.originalWidths[index], curFrame.size.height)
            }) { (b: Bool) -> Void in
                    self.specialityButtons[index].setTitle(self.specialityButtons[index].originalTitle, forState: .Normal)
            }
        }
        
        for index in 4...titles.count - 1
        {
            UIView.animateWithDuration(0.4, delay: Double(index) * 0.15, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                let curFrame = self.specialityButtons[index].frame
                self.specialityButtons[index].frame = CGRectMake(curFrame.origin.x - (self.originalWidths[index] - 25), curFrame.origin.y, self.originalWidths[index], curFrame.size.height)
                self.specialityButtons[index].layoutIfNeeded()
                }) { (b: Bool) -> Void in
                    self.specialityButtons[index].setTitle(self.specialityButtons[index].originalTitle, forState: .Normal)
            }
        }
        
        addArrowImage()
    }
    
    func addArrowImage()
    {
        let arrowImageView = UIImageView(frame: CGRectMake(90, specialityButtons[3].frame.origin.y + 10, 72, 72))
        arrowImageView.image = UIImage(named: "arrowupwardicon")
        arrowImageView.alpha = 0.0
        self.view.insertSubview(arrowImageView, belowSubview: specialityView!)
        
        // add the text under the arrow
        let arrowTextLabel = UILabel(frame: CGRectMake(16, arrowImageView.frame.origin.y + arrowImageView.frame.size.height - 15, 250, 30))
        arrowTextLabel.text = "Click on any speciality to see more!"
        arrowTextLabel.font = UIFont.systemFontOfSize(14)
        arrowTextLabel.textColor = UIColor.darkGrayColor()
        arrowTextLabel.alpha = 0.0
        
        self.view.insertSubview(arrowTextLabel, belowSubview: specialityView!)
        
        UIView.animateWithDuration(0.4, delay: 1.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            arrowImageView.alpha = 1.0
            arrowTextLabel.alpha = 1.0
        }, completion: nil)
    }
    
    func addSpecialitiesButton(title: String, x: CGFloat, y: CGFloat, index: Int)
    {
        let specialitiesButton = SpecialitiesButton.buttonWithType(.System) as! SpecialitiesButton
        specialitiesButton.frame = CGRectMake(x, y, 25, 25)
        specialitiesButton.setTitle("", forState: .Normal)
        specialitiesButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        specialitiesButton.backgroundColor = UIColor(red: 220.0/255.0, green: 130.0/255.0, blue: 30.0/255.0, alpha: 1.0)
        specialitiesButton.originalTitle = title
        specialitiesButton.tag = 100 + index
        specialitiesButton.addTarget(self, action: "specialityButtonPressed:", forControlEvents: .TouchUpInside)
        
        specialitiesButton.layer.cornerRadius = specialitiesButton.frame.size.width / 2
        specialityButtons.append(specialitiesButton)
        
        self.view.insertSubview(specialitiesButton, belowSubview: self.menuView!)
    }
    
    func specialityButtonPressed(button: UIButton)
    {
        currentlySelectedButton = button as? SpecialitiesButton
        oldButtonPosition = currentlySelectedButton?.frame.origin
        
        // make the button animation
        let buttonIndex = button.tag - 100
        button.setTitle("", forState: .Normal)
        if buttonIndex <= 3
        {
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                button.frame = CGRectMake(16, button.frame.origin.y, 25, 25)
            }) { (b: Bool) -> Void in
                self.moveButtonToCenter(button)
            }
        }
        else
        {
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                button.frame = CGRectMake(UIScreen.mainScreen().bounds.size.width - 16 - 25, button.frame.origin.y, 25, 25)
            }) { (b: Bool) -> Void in
                self.moveButtonToCenter(button)
            }
        }
    }
    
    func moveButtonToCenter(button: UIButton)
    {
        let screenRect = UIScreen.mainScreen().bounds
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            button.frame = CGRectMake(CGRectGetMidX(screenRect) - 25/2, CGRectGetMidY(screenRect) - 25/2, 25, 25)
        }) { (b: Bool) -> Void in
            self.openSpecialityView()
        }
    }
    
    func openSpecialityView()
    {
        specialityView?.hidden = false
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            specialityView?.transform = CGAffineTransformMakeScale(1, 1)
        }) { (b: Bool) -> Void in
                // ...
        }
    }
    
    func specialityViewCloseAnimationFinished(notification: NSNotification)
    {
        // restore the button to its original position
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.currentlySelectedButton!.frame = CGRectMake(self.oldButtonPosition!.x, self.oldButtonPosition!.y, 25, 25)
        }) { (b: Bool) -> Void in
            self.collapseButton()
        }
    }
    
    func collapseButton()
    {
        let buttonIndex = currentlySelectedButton!.tag - 100
        UIView.animateWithDuration(0.4, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            let curFrame = self.specialityButtons[buttonIndex].frame
            self.specialityButtons[buttonIndex].frame = CGRectMake(curFrame.origin.x, curFrame.origin.y, self.originalWidths[buttonIndex], curFrame.size.height)
        }) { (b: Bool) -> Void in
            self.specialityButtons[buttonIndex].setTitle(self.specialityButtons[buttonIndex].originalTitle, forState: .Normal)
        }
        currentlySelectedButton = nil
    }
    
    @IBAction func interestsButtonPressed()
    {
        self.performSegueWithIdentifier("InterestsSegue", sender: self)
    }
}