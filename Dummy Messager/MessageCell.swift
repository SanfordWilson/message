//
//  MessageCell.swift
//  Dummy Messager
//
//  Created by Sanford Wilson on 6/20/17.
//  Copyright © 2017 Sanford Wilson. All rights reserved.
//

import UIKit

class MessageCell: Cell {
    
    static let profilePictureRadius: CGFloat = 10.0
    
    let textView: UITextView = {
        let view = UITextView()
        view.font = UIFont.systemFont(ofSize: 18)
        view.text = "Test test test"
        view.textColor = UIColor.darkText
        view.backgroundColor = UIColor.clear
        view.isEditable = false
        return view
    }()
    
    let bubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.9, alpha: 1)
        //view.layer.cornerRadius = 20
        //view.layer.masksToBounds = true
        return view
    }()
    
    let profilePictureView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = MessageCell.profilePictureRadius
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = UIColor.white
        return imageView
    }()
    
    override func shapeCell() {
        super.shapeCell()
        backgroundColor = UIColor.white
        addSubview(bubbleView)
        addSubview(textView)
        addSubview(profilePictureView)
        visuallyFormat(format: "H:|-5-[v0(\(Int(MessageCell.profilePictureRadius)*2))]", views: profilePictureView)
        visuallyFormat(format: "V:[v0(\(Int(MessageCell.profilePictureRadius)*2))]|", views: profilePictureView)
        bubbleView.addSubview(bubbleImageView)
        bubbleView.visuallyFormat(format: "H:|[v0]|", views: bubbleImageView)
        bubbleView.visuallyFormat(format: "V:|[v0]|", views: bubbleImageView)
    }
    
    let bubbleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "RightChatBubble")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.white
        return imageView
    }()
}
