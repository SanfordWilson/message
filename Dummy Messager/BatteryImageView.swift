//
//  BatteryImageView.swift
//  Dummy Messager
//
//  Created by Sanford Wilson on 8/16/17.
//  Copyright © 2017 Sanford Wilson. All rights reserved.
//

import UIKit

class BatteryImageView: UIImageView {

    enum BatteryLevel: Int {
        case dying = 1
        case low = 2
        case medium = 3
        case full = 4
    }

    private var batteryLevel: BatteryLevel?

    required init?(coder aDecoder: NSCoder) {
        fatalError("No code, chode")
    }

    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        batteryLevel = .medium
        setUpViews()
    }

    func setUpViews() {
        contentMode = .scaleAspectFit
        setBatteryLevel(level: .full)
    }

    func setBatteryLevel(level: BatteryLevel) {
        image = UIImage(named: "BatteryFill\(level.rawValue)")
        batteryLevel = level
    }
}
