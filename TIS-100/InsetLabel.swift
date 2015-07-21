//
//  InsetLabel.swift
//  TIS-100
//
//  Created by Brad Slayter on 7/21/15.
//  Copyright © 2015 Flipped Bit. All rights reserved.
//

import UIKit

class InsetLabel: UILabel {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override func drawTextInRect(rect: CGRect) {
        let insets = UIEdgeInsetsMake(10.5, 10.5, 10.5, 10.5)
        super.drawTextInRect(UIEdgeInsetsInsetRect(rect, insets))
    }

}
