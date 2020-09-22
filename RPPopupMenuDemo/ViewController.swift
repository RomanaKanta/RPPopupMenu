//
//  ViewController.swift
//  RPPopupMenu
//
//  Created by Romana on 21/9/20.
//  Copyright © 2020 romana. All rights reserved.
//

import UIKit
import RPPopupMenu

class ViewController: UIViewController, RPPopupMenuDelegate {
    
    @IBOutlet weak var rpMenu: RPPopupMenu!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rpMenu.backgroundEffect = .plain
        rpMenu.viewBgColor = UIColor.purple
        rpMenu.tableAnimation = .moveUpWithBounce
        rpMenu.delegate = self
        rpMenu.updateList([
            RPPopupMenuModel.init(id: 1, title: "Menu 1", image: "ic_add_fav.png", color: UIColor.blue),
            RPPopupMenuModel.init(id: 2, title: "Menu 2", image: "ic_add_fav.png", color: UIColor.red),
            RPPopupMenuModel.init(id: 3, title: "Menu 3", image: "ic_add_fav.png", color: UIColor.green),
            RPPopupMenuModel.init(id: 4, title: "Menu 4", image: "ic_add_fav.png", color: UIColor.brown),
            RPPopupMenuModel.init(id: 5, title: "Menu 5", image: "ic_add_fav.png", color: UIColor.black),
            RPPopupMenuModel.init(id: 6, title: "Menu 6", image: "ic_add_fav.png", color: UIColor.cyan),
            RPPopupMenuModel.init(id: 7, title: "Menu 7", image: "ic_add_fav.png", color: UIColor.darkGray),
            RPPopupMenuModel.init(id: 8, title: "Menu 8", image: "ic_add_fav.png", color: UIColor.magenta),
            RPPopupMenuModel.init(id: 9, title: "Menu 9", image: "ic_add_fav.png", color: UIColor.purple),
            RPPopupMenuModel.init(id: 10, title: "Menu 10", image: "ic_add_fav.png", color: UIColor.orange)
        ])
    }
    
    func optionChoose(_ menu:RPPopupMenu, index:Int, value:RPPopupMenuModel){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        viewController.menuName = value.itemTitle
        viewController.bgColor = value.tintColor
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true, completion: nil)
    }
}
