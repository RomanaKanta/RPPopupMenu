//
//  RPPopupMenu.swift
//  RPPopupMenu
//
//  Created by Romana on 22/9/20.
//  Copyright © 2020 romana. All rights reserved.
//

import UIKit

enum RPPopupMenuBackgroundEffect {
    case plain
    case blur
}

enum RPPopupMenuAnimation {
    case fade
    case moveUpWithBounce
    case slideInLeft
    case slideInRight
    case moveUpWithFade
}

@IBDesignable class RPPopupMenu: UIView, UITableViewDelegate, UITableViewDataSource {
    // RPPopupMenu Button property
    @IBInspectable var textFont: UIFont = UIFont.systemFont(ofSize: 17.0) { didSet{ updateUI() } }
    @IBInspectable var text: String = "" { didSet{ updateUI() } }
    @IBInspectable var textColor: UIColor = UIColor.black { didSet{ updateUI() } }
    @IBInspectable var icon: UIImage? { didSet{ updateUI() } }
    @IBInspectable var iconTintColor: UIColor = UIColor.black  { didSet{ updateUI() } }
    @IBInspectable var buttonTintColor: UIColor = UIColor.gray  { didSet{ updateUI() } }
    fileprivate var menuButton: UIButton!
    
    fileprivate var firstDraw: Bool = true
    let padding: CGFloat = 30
    let cellHeight: CGFloat = 70
    let closeButtonSize: CGFloat = 50
    fileprivate let cellID = "RPPopupMenuCell"
    
    fileprivate var tableviewChoose: UITableView!
    fileprivate var lastSuperView: UIView?
    var list: [RPPopupMenuModel]  = [RPPopupMenuModel]()
    var backgroundEffect: RPPopupMenuBackgroundEffect = .blur
    var tableAnimation: RPPopupMenuAnimation = .slideInLeft
    var delegate:RPPopupMenuDelegate!
    fileprivate(set) internal var selectedIndex = 0
    fileprivate var blurEffectView: UIVisualEffectView!
    fileprivate var plainView: UIView!
    fileprivate var viewChooseDisable: UIView!
    var viewBgColor: UIColor = .brown
    lazy var closeButton: UIButton = {
        let view = UIButton(frame: CGRect(x: 0, y: 0, width: closeButtonSize, height: closeButtonSize))
        view.layer.cornerRadius = (closeButtonSize/2)
        view.layer.backgroundColor = UIColor.white.cgColor
        view.tintColor = UIColor.black
        view.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        view.setImage(UIImage(named: "ic_close_black_48.png")!.withRenderingMode(.alwaysTemplate), for: .normal)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initCustomView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initCustomView()
    }
    
    override func prepareForInterfaceBuilder() {
        backgroundColor = UIColor.clear
    }
    
    fileprivate func initCustomView() {
        backgroundColor = UIColor.clear
        let gesture = UITapGestureRecognizer(target: self, action: #selector(openMenu(_:)))
        addGestureRecognizer(gesture)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if firstDraw {
            var frame = bounds
            frame.origin = CGPoint(x: frame.origin.x, y: frame.origin.y)
            menuButton = UIButton(frame: frame)
            menuButton.backgroundColor = buttonTintColor
            addSubview(menuButton)
            menuButton.isEnabled = false
            updateUI()
            firstDraw = false
        }
    }
    
    fileprivate func updateUI() {
        if (menuButton != nil) {
            menuButton.setTitle(text, for: .normal)
            menuButton.setTitleColor(textColor, for: .normal)
            menuButton.titleLabel?.font = textFont
            if(icon != nil){
                menuButton.setImage(icon, for: .normal)
                menuButton.tintColor = iconTintColor
            }
            menuButton.backgroundColor = buttonTintColor
        }
        setNeedsDisplay()
    }
    
    func changeSelectedIndex(_ index:Int) {
        if list.count > index {
            selectedIndex = index
            if (delegate != nil) {
                delegate.optionChoose(self, index:selectedIndex, value: list[selectedIndex])
            }
        }
    }
    
    func updateList(_ list:[RPPopupMenuModel]) {
        self.list = list;
    }
    
    @objc func openMenu(_ sender:UITapGestureRecognizer){
        let parentView = findLastUsableSuperview()
        viewChooseDisable = UIView(frame: parentView.frame)
        switch(backgroundEffect){
        case .blur:
            let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
            blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.alpha = 0 // blur effect alpha
            blurEffectView.frame = viewChooseDisable.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            viewChooseDisable.addSubview(blurEffectView)
            break
        case .plain:
            plainView = UIView(frame: viewChooseDisable.bounds)
            plainView.backgroundColor = viewBgColor
            plainView.alpha = 0 // blur effect alpha
            //            plainView.frame = viewChooseDisable.bounds
            plainView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            viewChooseDisable.addSubview(plainView)
            break
        }
        
        let closeBtnY: CGFloat = viewChooseDisable.frame.height - closeButtonSize - padding
        
        closeButton.frame = CGRect(x: (viewChooseDisable.frame.width - closeButtonSize)/2 , y: closeBtnY, width: closeButtonSize, height: closeButtonSize)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(RPPopupMenu.closeMenu))
        closeButton.addGestureRecognizer(gesture)
        viewChooseDisable.addSubview(closeButton)
        
        var tableHt: CGFloat = cellHeight * CGFloat(list.count)
        let tableMaxHt: CGFloat = closeBtnY - (padding * 2)
        if(tableHt > tableMaxHt) {
            tableHt = tableMaxHt
        }
        let tableY: CGFloat = closeBtnY - padding - tableHt
        
        tableviewChoose = UITableView(frame: CGRect(x: padding , y: tableY, width: (viewChooseDisable.frame.width - (padding * 2)), height: tableHt))
        tableviewChoose.backgroundColor = .clear
        tableviewChoose.tableFooterView = UIView() //Eliminate Extra separators below UITableView
        tableviewChoose.delegate = self
        tableviewChoose.dataSource = self
        tableviewChoose.register(RPPopupMenuCell.self, forCellReuseIdentifier: cellID)
        tableviewChoose.isUserInteractionEnabled = true
        tableviewChoose.showsHorizontalScrollIndicator = false
        tableviewChoose.showsVerticalScrollIndicator = false
        tableviewChoose.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableviewChoose.isScrollEnabled = false
        if (tableHt == tableMaxHt){
            tableviewChoose.isScrollEnabled = true
        }
        viewChooseDisable.addSubview(tableviewChoose)
        
        parentView.addSubview(viewChooseDisable)
        
        UIView.animate(withDuration: 0.2,
                       delay: 0.0,
                       options: UIView.AnimationOptions.transitionFlipFromBottom,
                       animations: {
                        if self.blurEffectView != nil {
                            self.blurEffectView.alpha = 0.7
                        }
                        if self.plainView != nil {
                            self.plainView.alpha = 0.8
                        }
                        if self.tableviewChoose != nil {
                            self.tableviewChoose.reloadData()
                        }
        },
                       completion: { finished in
        })
    }
    
    @objc func closeMenu() {
        if(tableviewChoose != nil) {
            UIView.animate(withDuration: 0.3,
                           delay: 0.0,
                           options: UIView.AnimationOptions.transitionFlipFromBottom,
                           animations: {
                            self.tableviewChoose.alpha = 0.0
                            self.viewChooseDisable.alpha = 0.0
            },
                           completion: { finished in
                            if(self.tableviewChoose != nil) {
                                self.tableviewChoose.removeFromSuperview()
                            }
                            if(self.viewChooseDisable != nil) {
                                self.viewChooseDisable.removeFromSuperview()
                            }
                            self.tableviewChoose = nil
                            self.viewChooseDisable = nil
            })
        }
    }
    
    fileprivate func findLastUsableSuperview() -> UIView {
        if lastSuperView == nil {
            var lastView: UIView = self
            var continueWhile = true
            while continueWhile {
                if let superView = lastView.superview {
                    lastView = superView
                } else {
                    continueWhile = false
                }
            }
            lastSuperView = lastView
        }
        return lastSuperView!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (delegate != nil) {
            delegate.optionChoose(self, index:indexPath.row, value: list[indexPath.row])
        }
        selectedIndex = indexPath.row
        closeMenu()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    var animation: Animation!
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableviewChoose.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! RPPopupMenuCell
        let item: RPPopupMenuModel = list[indexPath.row]
        cell.indicator.backgroundColor = item.tintColor
        cell.icon.image = UIImage(named: item.itemImage)
        cell.icon.tintColor = item.tintColor
        cell.title.text = item.itemTitle
        switch tableAnimation {
        case .fade:
            animation = AnimationFactory.makeFade(duration: 0.4, delayFactor: 0.04)
            break
        case .slideInLeft:
            animation = AnimationFactory.makeSlideIn(duration: 0.4, delayFactor: 0.04)
            break
        case .slideInRight:
            animation = AnimationFactory.makeSlideInRight(duration: 0.4, delayFactor: 0.04)
            break
        case .moveUpWithBounce:
            animation = AnimationFactory.makeMoveUpWithBounce(rowHeight: cell.frame.height, duration: 0.8, delayFactor: 0.04)
            break
        case .moveUpWithFade:
            animation = AnimationFactory.makeMoveUpWithFade(rowHeight: cell.frame.height, duration: 0.8, delayFactor: 0.04)
            break
        default:
            break
        }
        if(animation != nil){
            let animator = Animator(animation: animation)
            animator.animate(cell: cell, at: indexPath, in: tableView)
        }
        return cell
    }
}

protocol RPPopupMenuDelegate{
    func optionChoose(_ menu:RPPopupMenu, index:Int, value:RPPopupMenuModel)
}

