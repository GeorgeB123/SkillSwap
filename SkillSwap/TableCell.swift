//
//  TableCell.swift
//  SkillSwap
//
//  Created by George Bonnici-Carter on 28/07/2017.
//  Copyright © 2017 George Bonnici-Carter. All rights reserved.
//

import UIKit

class TableCell: UITableViewCell {
    
    //MARK: Properties
    
    @IBOutlet weak var newSkillField: UITextField!
    
    @IBOutlet weak var levelField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        newSkillField.layer.borderColor = UIColor.clear.cgColor
        newSkillField.layer.borderWidth = 1.0
        newSkillField.layer.cornerRadius = 8
        levelField.layer.borderColor = UIColor.clear.cgColor
        levelField.layer.borderWidth = 1.0
        levelField.layer.cornerRadius = 8
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
