//
//  MessageCell.swift
//  Dummy Messager
//
//  Created by Sanford Wilson on 6/20/17.
//  Copyright © 2017 Sanford Wilson. All rights reserved.
//

import UIKit

class MessageCell: Cell {
    
    let textView: UITextView = {
        let view = UITextView()
        view.font = UIFont.systemFont(ofSize: 16)
        view.text = "Test test test"
        view.textColor = UIColor.darkText
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    let bubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.7, alpha: 1)
        return view
    }()
    
    override func shapeCell() {
        super.shapeCell()
        backgroundColor = UIColor.lightGray
        addSubview(bubbleView)
        addSubview(textView)
    }
}
