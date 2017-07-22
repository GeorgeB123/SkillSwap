//
//  MapsViewController.swift
//  SkillSwap
//
//  Created by George Bonnici-Carter on 22/07/2017.
//  Copyright © 2017 George Bonnici-Carter. All rights reserved.
//

import UIKit
import MapKit

class MapsViewController: UIViewController, MKMapViewDelegate {
    
    //MARK: Properties
    
    @IBOutlet weak var map: MKMapView!
    
    @IBOutlet weak var skillSearch: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    //MARK: Navigation
    
    @IBAction func goBack(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    

}
