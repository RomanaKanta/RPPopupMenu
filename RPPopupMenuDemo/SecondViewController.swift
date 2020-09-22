//
//  SecondViewController.swift
//  RPPopupMenu
//
//  Created by Romana on 21/9/20.
//  Copyright © 2020 romana. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    var menuName = "SecondView"
    var bgColor: UIColor = .white
    
    @IBAction func back(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = bgColor
        label.text = menuName
    }
}
