//
//  RPPopupMenuStyles.swift
//  RPPopupMenu
//
//  Created by Romana on 22/9/20.
//  Copyright © 2020 romana. All rights reserved.
//

import UIKit

class RPPopupMenuImageView: UIImageView {
    override var alignmentRectInsets: UIEdgeInsets {
        return UIEdgeInsets(top: -10, left: -10, bottom: -10, right: -10)
    }
}

class RPPopupMenuBG: UIView {
    
    var cornerradius: CGFloat = 5.0
    var shadowOffSetWidth : CGFloat = 0
    var shadowOffSetHeight : CGFloat = 4
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initCustomView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initCustomView()
    }
    
    func initCustomView() {
        self.backgroundColor = .white
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        layer.cornerRadius = cornerradius
        layer.shadowOffset = CGSize(width: shadowOffSetWidth, height: shadowOffSetHeight)
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerradius)
        layer.shadowPath = shadowPath.cgPath
    }
    
    override func layoutSubviews() {
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerradius)
        layer.shadowPath = shadowPath.cgPath
    }
}

