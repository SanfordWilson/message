//
//  DateLabel.swift
//  Dummy Messager
//
//  Created by Sanford Wilson on 8/16/17.
//  Copyright © 2017 Sanford Wilson. All rights reserved.
//

import UIKit

class DateLabel: UILabel {
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }()
    
    var timer: Timer?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("no coder, bro-der")
    }
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        setUpViews()
    }
    
    func setUpViews() {
        font = UIFont.boldSystemFont(ofSize: UIFont.smallSystemFontSize)
        updateTime()
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    func updateTime() {
        text = formatter.string(from: Date())
    }
    
    deinit {
        if let timer = timer {
            timer.invalidate()
        }
    }
}
