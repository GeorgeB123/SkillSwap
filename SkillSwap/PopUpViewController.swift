//
//  PopUpViewController.swift
//  SkillSwap
//
//  Created by George Bonnici-Carter on 31/07/2017.
//  Copyright © 2017 George Bonnici-Carter. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var table: UITableView!
    
    var cells = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.table.delegate = self
        self.table.dataSource = self
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        self.showAnimate()
        
        // Do any additional setup after loading the view.
        
        profilePicture.image = GlobalVar.Variables.users[GlobalVar.Variables.userId].photo
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close(_ sender: UIButton) {
        self.removeAnimate()
    }
    
    private func showAnimate(){
        self.view.transform = CGAffineTransform(scaleX: 1.3,y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    private func removeAnimate() {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3,y: 1.3)
            self.view.alpha = 0.0
        }, completion: {(finished: Bool) in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
    
    //MARK: UITableViewelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cells.count    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // 1
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.table.dequeueReusableCell(withIdentifier: "PopUpTableCell", for: indexPath as IndexPath) as! PopUpTableCell
        cell.label.text = "Dicks"
        return cell
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
