//
//  RPPopupMenuCell.swift
//  RPPopupMenu
//
//  Created by Romana on 22/9/20.
//  Copyright © 2020 romana. All rights reserved.
//

import UIKit

class RPPopupMenuCell: UITableViewCell{
    
    let stackview: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let indicator: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0 , y: 0, width: 8, height: 50)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let icon: RPPopupMenuImageView = {
        let view = RPPopupMenuImageView()
        view.frame = CGRect(x: 0 , y: 10, width: 50, height: 50)
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let title: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = UIFont.systemFont(ofSize: 14)
        view.textColor = UIColor.black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let bgView = RPPopupMenuBG()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        bgView.backgroundColor = .white
        bgView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bgView)
        
        stackview.addArrangedSubview(indicator)
        stackview.addArrangedSubview(icon)
        stackview.addArrangedSubview(title)
        
        addSubview(stackview)
        
        let constraints = [
            indicator.widthAnchor.constraint(equalToConstant: 8),
            indicator.heightAnchor.constraint(equalToConstant: 50),
            icon.widthAnchor.constraint(equalToConstant: 50),
            icon.heightAnchor.constraint(equalToConstant: 50),
            
            stackview.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            stackview.widthAnchor.constraint(equalTo: widthAnchor, constant: -32),
            
            bgView.topAnchor.constraint(equalTo: stackview.topAnchor, constant: 0),
            bgView.leadingAnchor.constraint(equalTo: stackview.leadingAnchor, constant: 0),
            bgView.bottomAnchor.constraint(equalTo: stackview.bottomAnchor, constant: 0),
            bgView.trailingAnchor.constraint(equalTo: stackview.trailingAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
