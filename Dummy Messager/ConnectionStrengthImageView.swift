//
//  ConnectionStrengthImageView.swift
//  Dummy Messager
//
//  Created by Sanford Wilson on 8/16/17.
//  Copyright © 2017 Sanford Wilson. All rights reserved.
//

import UIKit

class ConnectionStrengthImageView: UIImageView {
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        contentMode = .scaleAspectFit
        image = UIImage(named: "ConnectionLevel1")
    }
    
    func setLevel(connectionLevel: Int) {
        if (1...5).contains(connectionLevel) {
            image = UIImage(named: "ConnectionLevel\(String(connectionLevel))")
        }
    }
}
