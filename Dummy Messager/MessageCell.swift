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
        view.font = UIFont.preferredFont(forTextStyle: .body)
        view.text = "Test test test"
        view.textColor = UIColor.darkText
        view.backgroundColor = UIColor.clear
        view.isEditable = false
        return view
    }()

    let bubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.9, alpha: 1)
        return view
    }()

    let profileImageView = ProfileImageView(radius: profilePictureRadius)

    override func shapeCell() {
        super.shapeCell()
        backgroundColor = UIColor.white
        addSubview(bubbleView)
        addSubview(textView)
        addSubview(profileImageView)
        visuallyFormat(format: "H:|-5-[v0(\(Int(MessageCell.profilePictureRadius)*2))]", views: profileImageView)
        visuallyFormat(format: "V:[v0(\(Int(MessageCell.profilePictureRadius)*2))]|", views: profileImageView)
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
