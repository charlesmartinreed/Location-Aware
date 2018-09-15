//
//  ViewController.swift
//  LocationAware
//
//  Created by Charles Martin Reed on 9/15/18.
//  Copyright © 2018 Charles Martin Reed. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    //MARK:- IBOutlets
    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var longitude: UILabel!
    @IBOutlet weak var course: UILabel!
    @IBOutlet weak var speed: UILabel!
    @IBOutlet weak var altitude: UILabel!
    
    @IBOutlet weak var subLocality: UILabel!
    @IBOutlet weak var subAdministrativeArea: UILabel!
    @IBOutlet weak var postalCode: UILabel!
    @IBOutlet weak var country: UILabel!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //make our location manager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
    }

    //MARK:- Handling the location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //if we can get a location at all
        let userLocation = locations[0]
        
        latitude.text = "\(userLocation.coordinate.latitude)"
        longitude.text = "\(userLocation.coordinate.longitude)"
        course.text = "\(userLocation.course)°"
        speed.text = "\(userLocation.speed) meters per second"
        altitude.text = "\(userLocation.altitude) meters"
        
        //MARK:- For debugging purposes... DELETE WHEN DONE!
        print(locations)
        
        //MARK:- Getting the geolocation information
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                //try to get the placemark data - using ? because placemark is an optional data type until we confirm we have nearby placemarks
                guard let placemark = placemarks?[0] else { return }
                
                //place the placemark data in the labels
                if let thoroughfare = placemark.thoroughfare {
                    self.subLocality.text = thoroughfare
                    print(thoroughfare)
                }
                
                if let subAdministrativeArea = placemark.subAdministrativeArea {
                    self.subAdministrativeArea.text = subAdministrativeArea
                    print(subAdministrativeArea)
                }
                
                if let postalCode = placemark.postalCode {
                    self.postalCode.text = postalCode
                    print(postalCode)
                }
                
                if let country = placemark.country {
                    self.country.text = country
                    print(country)
                }
            }
        }
            
    }

}

