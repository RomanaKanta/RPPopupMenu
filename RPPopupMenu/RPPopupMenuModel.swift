//
//  RPPopupMenuModel.swift
//  RPPopupMenu
//
//  Created by Romana on 22/9/20.
//  Copyright © 2020 romana. All rights reserved.
//

import Foundation
import UIKit

class RPPopupMenuModel {
    var itemID: UInt
    var itemTitle: String
    var itemImage: String
    var tintColor: UIColor = UIColor.white
        
    init(id: UInt, title: String, image: String, color: UIColor){
        self.itemID = id
        self.itemTitle = title
        self.itemImage = image
        self.tintColor = color
    }
}
