//
//  SetListTableViewCell.swift
//  Baito_Swift
//
//  Created by Robert Lyons on 5/24/16.
//  Copyright © 2016 Robert Lyons. All rights reserved.
//

import UIKit

class SetListTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var setNameButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
