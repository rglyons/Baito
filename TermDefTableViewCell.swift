//
//  TermDefTableViewCell.swift
//  Baito_Swift
//
//  Created by Robert Lyons on 5/24/16.
//  Copyright © 2016 Robert Lyons. All rights reserved.
//

import UIKit

class TermDefTableViewCell: UITableViewCell {
    
    //MARK: Properties
    
    @IBOutlet weak var termTextField: UITextField!
    @IBOutlet weak var definitionTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
