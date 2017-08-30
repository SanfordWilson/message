//
//  SignalTypeLabel.swift
//  Dummy Messager
//
//  Created by Sanford Wilson on 8/16/17.
//  Copyright © 2017 Sanford Wilson. All rights reserved.
//

import UIKit

class SignalTypeLabel: UILabel {

    enum SignalType {
        case oneX
        case threeG
        case lte
        case wifi
    }

    private var signalType: SignalType?

    required init?(coder aDecoder: NSCoder) {
        fatalError("A coder has not been implemented for this class")
    }

    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        setUpViews()
    }

    func setUpViews() {
        setSignalType(type: .lte)
        font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize, weight: UIFontWeightThin)
    }

    func setSignalType(type: SignalType) {
        isHidden = false
        switch type {
        case .oneX:
            text = "1x"
        case .threeG:
            text = "3G"
        case .lte:
            text = "LTE"
        case .wifi:
            isHidden = true
        }
        signalType = type
    }
}
