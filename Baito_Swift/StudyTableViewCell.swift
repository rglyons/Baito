//
//  StudyTableViewCell.swift
//  Baito_Swift
//
//  Created by Robert Lyons on 6/24/16.
//  Copyright © 2016 Robert Lyons. All rights reserved.
//

import UIKit

class StudyTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet var card: FlashCardView!
    var front: UIView!
    var back: UIView!
    var showingFront: Bool = true
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
