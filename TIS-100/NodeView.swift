//
//  NodeView.swift
//  TIS-100
//
//  Created by Brad Slayter on 7/21/15.
//  Copyright © 2015 Flipped Bit. All rights reserved.
//

import UIKit

class NodeView: UIView, UITextViewDelegate, BasicNodeDelegate {
    var sourceView: UITextView
    let ACCLbl: InsetLabel
    let BAKLbl: InsetLabel
    let idleLbl: InsetLabel
    
    let node: BasicNode
    
	init(frame: CGRect, nodeId: Int, manager: NodeManager) {
        self.sourceView = UITextView(frame: CGRectMake(0, 0, frame.width - 75, frame.height - 20 + 1.5))
        self.sourceView.autocapitalizationType = .AllCharacters
        self.sourceView.font = UIFont(name: "CourierNewPS-BoldMT", size: 16.0)
        self.sourceView.text = "MOV 5, ACC"
        self.sourceView.backgroundColor = UIColor.blackColor()
        self.sourceView.textColor = UIColor.whiteColor()
        self.sourceView.layer.borderColor = UIColor.whiteColor().CGColor
        self.sourceView.layer.borderWidth = 10.0
        self.sourceView.textContainerInset = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0)
        
        self.ACCLbl = InsetLabel(frame: CGRectMake(frame.width - 85, 0, 80, frame.height / 3))
        self.ACCLbl.font = UIFont(name: "CourierNewPS-BoldMT", size: 18.0)
        self.ACCLbl.textColor = UIColor.whiteColor()
        self.ACCLbl.backgroundColor = UIColor.blackColor()
        self.ACCLbl.numberOfLines = 0
        self.ACCLbl.text = "ACC: \n0"
        self.ACCLbl.layer.borderColor = UIColor.whiteColor().CGColor
        self.ACCLbl.layer.borderWidth = 10.0
        
        
        self.BAKLbl = InsetLabel(frame: CGRectMake(frame.width - 85, frame.height * 0.3, 80, frame.height / 3))
        self.BAKLbl.font = UIFont(name: "CourierNewPS-BoldMT", size: 18.0)
        self.BAKLbl.textColor = UIColor.whiteColor()
        self.BAKLbl.backgroundColor = UIColor.blackColor()
        self.BAKLbl.numberOfLines = 0
        self.BAKLbl.text = "BAK: \n0"
        self.BAKLbl.layer.borderColor = UIColor.whiteColor().CGColor
        self.BAKLbl.layer.borderWidth = 10.0
        
        self.idleLbl = InsetLabel(frame: CGRectMake(frame.width - 85, frame.height * 0.6, 80, frame.height / 3))
        self.idleLbl.font = UIFont(name: "CourierNewPS-BoldMT", size: 18.0)
        self.idleLbl.textColor = UIColor.whiteColor()
        self.idleLbl.backgroundColor = UIColor.blackColor()
        self.idleLbl.numberOfLines = 0
        self.idleLbl.text = "idle: 0%"
        self.idleLbl.layer.borderColor = UIColor.whiteColor().CGColor
        self.idleLbl.layer.borderWidth = 10.0
        
		self.node = BasicNode(withId: nodeId, manager: manager)
		
        super.init(frame: frame)
        
        self.addSubview(self.sourceView)
        self.addSubview(self.ACCLbl)
        self.addSubview(self.BAKLbl)
        self.addSubview(self.idleLbl)
        
        self.sourceView.delegate = self
        self.node.delegate = self
    }

    func didUpdateRegisters() {
        self.ACCLbl.text = "ACC:\n" + String(node.ACC)
        self.BAKLbl.text = "BAK:\n" + String(node.BAK)
        self.idleLbl.text = "idle:\n" + String(node.idleLvl * 100) + "%"
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
		
		let beg = textView.beginningOfDocument
		let start = textView.positionFromPosition(beg, offset: range.location)
		let end = textView.positionFromPosition(start!, offset: range.length)
		let textRange = textView.textRangeFromPosition(start!, toPosition: end!)
		
		textView.replaceRange(textRange!, withText: text.uppercaseString)
        
        return false
    }
}
