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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        appsImageView.layer.cornerRadius = appsImageView.frame.size.width / 2
        appsImageView.layer.masksToBounds = true
        
        companyButton.layer.cornerRadius = companyButton.frame.size.width / 2
        companyButton.layer.masksToBounds = true
    }
}