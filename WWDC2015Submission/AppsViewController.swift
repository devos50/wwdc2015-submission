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
    @IBOutlet weak var appsImageView: UIImageView!
    @IBOutlet weak var companyButton: UIButton!
    @IBOutlet weak var appsGraphView: AppsGraphView!
    private var appDescriptionView: AppDescriptionView?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        appsImageView.layer.cornerRadius = appsImageView.frame.size.width / 2
        appsImageView.layer.masksToBounds = true
        
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
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        appsGraphView.createGraph()
    }
}