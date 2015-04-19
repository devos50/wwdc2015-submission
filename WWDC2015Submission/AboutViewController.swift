//
//  AboutViewController.swift
//  WWDC2015Submission
//
//  Created by Martijn de Vos on 4/18/15.
//  Copyright (c) 2015 CodeUp. All rights reserved.
//

import UIKit
import MapKit

class AboutViewController: PageViewController
{
    @IBOutlet weak var photoRotatingButton: RotatingButton!
    @IBOutlet weak var appsButton: UIButton!
    @IBOutlet weak var locationMapView: MKMapView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        photoRotatingButton.layer.cornerRadius = photoRotatingButton.frame.size.width / 2
        photoRotatingButton.layer.masksToBounds = true
        
        appsButton.layer.cornerRadius = appsButton.frame.size.width / 2
        appsButton.layer.masksToBounds = true
        
        initializeMapView()
    }
    
    func initializeMapView()
    {
        let myLocation = CLLocationCoordinate2DMake(51.549232, 4.073744)
        let dropPin = MKPointAnnotation()
        dropPin.coordinate = myLocation
        dropPin.title = "My Location"
        locationMapView.addAnnotation(dropPin)
        
        let coordinateRegion = MKCoordinateRegionMake(myLocation, MKCoordinateSpanMake(0.2, 0.2))
        locationMapView.setRegion(coordinateRegion, animated: true)
    }
    
    @IBAction func appsButtonPressed(button: UIButton)
    {
        self.performSegueWithIdentifier("AppsSegue", sender: self)
    }
}
