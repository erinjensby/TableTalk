//
//  MapView.swift
//  TableTalk
//
//  Created by Patrick Liu on 3/6/17.
//  Copyright © 2017 Patrick Liu. All rights reserved.
//

import UIKit
import MapKit

class MapView: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    let regionRadius: CLLocationDistance = 1000
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
        // Do any additional setup after loading the view.
        let initialLocation = CLLocation(latitude: 30.285012, longitude: -97.734203)
        centerMapOnLocation(location: initialLocation)
        
        let pinLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(30.29, -97.73)
        let objectAnnotation = MKPointAnnotation()
        
        objectAnnotation.coordinate = pinLocation
        objectAnnotation.title = "Epoch"
        
        self.mapView.addAnnotation(objectAnnotation)
        self.mapView.showsUserLocation = true
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
