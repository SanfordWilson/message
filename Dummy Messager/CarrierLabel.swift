//
//  CarrierLabel.swift
//  Dummy Messager
//
//  Created by Sanford Wilson on 8/16/17.
//  Copyright © 2017 Sanford Wilson. All rights reserved.
//

import UIKit

class CarrierLabel: UILabel {

    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        setUpViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUpViews() {
        text = "Carrier"
        font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
    }

    func setCarrier(name: String) {
        text = name.capitalized
    }
}
