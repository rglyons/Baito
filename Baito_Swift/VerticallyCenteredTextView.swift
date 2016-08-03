//
//  VerticallyCenteredTextView.swift
//  Custom TextView class that centers content vertically
//  Baito_Swift
//
//  Created by Robert Lyons on 6/26/16.
//  Copyright © 2016 Robert Lyons. All rights reserved.
//

import UIKit

class VerticallyCenteredTextView: UITextView {
    
    override var contentSize: CGSize {
        didSet {
            var topCorrection = (bounds.size.height - contentSize.height * zoomScale) / 2.0
            topCorrection = max(0, topCorrection)
            contentInset = UIEdgeInsets(top: topCorrection, left: 0, bottom: 0, right: 0)
        }
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
