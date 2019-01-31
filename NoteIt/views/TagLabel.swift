//
//  TagLabel.swift
//  NoteIt
//
//  Created by Nikesh Jha on 1/31/19.
//  Copyright © 2019 Nikesh Jha. All rights reserved.
//

import UIKit

@IBDesignable
class TagLabel: UILabel {

    @IBInspectable var topInset: CGFloat = 2.0
    @IBInspectable var bottomInset: CGFloat = 2.0
    @IBInspectable var leftInset: CGFloat = 2.0
    @IBInspectable var rightInset: CGFloat = 2.0

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 20
        self.frame.size.height = 25
        backgroundColor = UIColor.green
        font = UIFont(name: "Halvetica", size: 11)
        textAlignment = .center
        numberOfLines = 1
        sizeToFit()
        
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: 25)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
