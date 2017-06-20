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
    
    //placeholder name
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Janani Lee"
        return label
    }()
    
    let snippetLabel: UILabel = {
        let label = UILabel()
        label.text = "Hey there, sexy Dashy"
        label.textColor = UIColor.darkGray
        return label
    }()
    
    override func shapeCell() {
        backgroundColor = UIColor.white
        
        addSubview(profileImageView)
        
        //placeholder image
        profileImageView.image = UIImage(named: "Janani")
        
        //size and place the profile image
        visuallyFormat(format: "H:|-20-[v0(60)]", views: profileImageView)
        visuallyFormat(format: "V:[v0(60)]", views: profileImageView)
        addConstraint(NSLayoutConstraint(item: profileImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        addSubview(dividerLine)
        
        
        //size and place the divider line
        visuallyFormat(format: "H:|-20-[v0]|", views: dividerLine)
        visuallyFormat(format: "V:[v0(1)]|", views: dividerLine)
        
        //set up preview containter
        let containerView = UIView()
        containerView.backgroundColor = UIColor.cyan
        
        //place preview container
        addSubview(containerView)
        visuallyFormat(format: "H:|-90-[v0]|", views: containerView)
        visuallyFormat(format: "V:[v0(60)]", views: containerView)
        addConstraint(NSLayoutConstraint(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        containerView.addSubview(nameLabel)
        containerView.addSubview(snippetLabel)
        
        containerView.visuallyFormat(format: "V:|[v0][v1(24)]", views: nameLabel, snippetLabel)
        containerView.visuallyFormat(format: "H:|[v0]|", views: nameLabel)
        containerView.visuallyFormat(format: "H:|[v0]|", views: snippetLabel)
        
    }
}
