//
//  AppInfo.swift
//  WWDC2015Submission
//
//  Created by Martijn de Vos on 19-04-15.
//  Copyright (c) 2015 CodeUp. All rights reserved.
//

import Foundation

class AppInfo: NSObject
{
    var logoName: String
    var appTitle: String
    var appDescription: String
    var screenshotName: String
    
    override init()
    {
        logoName = ""
        appTitle = ""
        appDescription = ""
        screenshotName = ""
        
        super.init()
    }
}