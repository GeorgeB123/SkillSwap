//
//  PopUpTableCell.swift
//  SkillSwap
//
//  Created by George Bonnici-Carter on 14/08/2017.
//  Copyright © 2017 George Bonnici-Carter. All rights reserved.
//

import UIKit

class PopUpTableCell: UITableViewCell {
    
    //MARK: Properties
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var labelImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        label.layer.borderColor = UIColor.clear.cgColor
        label.layer.borderWidth = 1.0
        label.layer.cornerRadius = 8
        labelImage.layer.borderColor = UIColor.clear.cgColor
        labelImage.layer.borderWidth = 1.0
        labelImage.layer.cornerRadius = 8
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
