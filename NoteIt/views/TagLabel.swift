//
//  TagLabel.swift
//  NoteIt
//
//  Created by Nikesh Jha on 1/31/19.
//  Copyright © 2019 Nikesh Jha. All rights reserved.
//

import UIKit

extension String {
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }
    
    func sizeOfString(usingFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes)
    }
}

@IBDesignable
class TagLabel: UILabel {

    @IBInspectable var topInset: CGFloat = 10
    @IBInspectable var bottomInset: CGFloat = 5
    @IBInspectable var leftInset: CGFloat = 5
    @IBInspectable var rightInset: CGFloat = 10

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    */
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        layer.cornerRadius = 20
//        self.frame.size.height = 25
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
//        font = UIFont(name: "Halvetica", size: 11)
        textAlignment = .center
        numberOfLines = 1
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset , bottom: bottomInset, right: rightInset)
        layer.cornerRadius = 10
        self.layer.masksToBounds = true
        var text = "VeryLongTextItIsBoroHahahahah"
        print(text.widthOfString(usingFont: UIFont.systemFont(ofSize: 11)))
        super.drawText(in: rect.inset(by: insets))
        
    }
    
//    override var intrinsicContentSize: CGSize {
//        let size = super.intrinsicContentSize
//        layer.cornerRadius = 10
//        self.layer.masksToBounds = true
//        self.frame.size.width = size.width + 5 * leftInset + rightInset * 2
//        return CGSize(width: size.width + leftInset + rightInset * 2,
//                      height: 25)
//    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
