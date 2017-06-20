//
//  ChatCell.swift
//  Dummy Messager
//
//  Created by Sanford Wilson on 6/19/17.
//  Copyright © 2017 Sanford Wilson. All rights reserved.
//

import UIKit

class ChatCell: Cell {
    /* Cell displaying an (optional) profile pic + default display, name of the chat, snippet, and "time"
    many many things left to add in here
    */
    
    //set up an empty imageview for the profile pic with scaling and circular border
    let profileImageView: UIImageView = {
        let profileView = UIImageView()
        profileView.contentMode = .scaleAspectFill
        profileView.layer.cornerRadius = 30
        profileView.layer.masksToBounds = true
        return profileView
    }()
    
    //set up an empty, gray view for a divider line
    let dividerLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.25)
        return view
    }()
    
    override func shapeCell() {
        backgroundColor = UIColor.white
        
        addSubview(profileImageView)
        
        //placeholder image
        profileImageView.image = UIImage(named: "Janani")
        
        //size and place the profile image
        visuallyFormat(format: "H:|-20-[v0(60)]", views: profileImageView)
        visuallyFormat(format: "V:|-20-[v0(60)]", views: profileImageView)
        
        addSubview(dividerLine)
        
        
        //size and place the divider line
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": dividerLine]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(1)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": dividerLine]))
        
    }
}
