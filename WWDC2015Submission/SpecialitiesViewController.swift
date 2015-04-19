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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        specialitiesButton.layer.cornerRadius = specialitiesButton.frame.size.width / 2
        specialitiesButton.layer.masksToBounds = true
    }
}