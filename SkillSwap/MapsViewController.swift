//
//  MapsViewController.swift
//  SkillSwap
//
//  Created by George Bonnici-Carter on 22/07/2017.
//  Copyright © 2017 George Bonnici-Carter. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapsViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    
    let regionRadius: CLLocationDistance = 1000
    
    @IBOutlet weak var map: MKMapView!
    
    @IBOutlet weak var skillSearch: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.map.delegate = self
        
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        map.showsUserLocation = true
        for users in GlobalVar.Variables.users {
            if users.location != [0, 0]{
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: users.location[0] , longitude: users.location[1])
                map.addAnnotation(annotation)
            }
        }
        map.showsUserLocation = true
//        centerMapOnLocation(location: initialLocation)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: MKMapViewDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        manager.stopUpdatingLocation()
        let coordinations = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude,longitude: userLocation.coordinate.longitude)
        let span = MKCoordinateSpanMake(0.2,0.2)
        let region = MKCoordinateRegion(center: coordinations, span: span)
        GlobalVar.Variables.users[GlobalVar.Variables.userId].location[0] = Double(userLocation.coordinate.latitude)
        GlobalVar.Variables.users[GlobalVar.Variables.userId].location[1] = Double(userLocation.coordinate.longitude)
        map.setRegion(region, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: Navigation
    
    @IBAction func goBack(_ sender: UIBarButtonItem) {
        print(GlobalVar.Variables.users[GlobalVar.Variables.userId].location[0])
        print(GlobalVar.Variables.users[GlobalVar.Variables.userId].location[1])
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Provate methods
    
    private func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        map.setRegion(coordinateRegion, animated: true)
    }
    
    @IBAction func showPopUp(_ sender: UIButton) {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbPopUp") as! PopUpViewController
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
    }
    

}
