//
//  ConditionalDateLabel.swift
//  Dummy Messager
//
//  Created by Sanford Wilson on 8/24/17.
//  Copyright © 2017 Sanford Wilson. All rights reserved.
//

import UIKit

class ConditionalDateLabel: UILabel {
    
    let formatter = DateFormatter()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("no coder")
    }
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        setUpViews()
    }
    
    func setDate(date: Date) {
        
    let timeSinceMessage = Date().timeIntervalSince(date)
            
        if timeSinceMessage > 60*60*24*7 {
            formatter.dateFormat = "MM/dd/yyyy"
        } else if timeSinceMessage > 60*60*24 {
            formatter.dateFormat = "EEEE"
        } else {
            formatter.dateFormat = "h:mm a"
        }
        text = formatter.string(from: date)
    }
    
    func setUpViews() {
        font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        textColor = UIColor.darkGray
        textAlignment = .right
    }
}
