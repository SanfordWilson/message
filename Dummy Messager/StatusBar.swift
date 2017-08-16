//
//  StatusBar.swift
//  Dummy Messager
//
//  Created by Sanford Wilson on 8/16/17.
//  Copyright © 2017 Sanford Wilson. All rights reserved.
//

import UIKit

class StatusBar: UIView {
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        addSubview(connectionStrengthImageView)
        addSubview(carrierLabel)
        addSubview(signalTypeLabel)
        addSubview(wifiStrengthButton)
        addSubview(dateLabel)
        addSubview(batteryImageView)
        addSubview(chargingImageView)
        visuallyFormat(format: "V:|-5-[v0]-5-|", views: connectionStrengthImageView)
        visuallyFormat(format: "V:|-5-[v0]-5-|", views: carrierLabel)
        visuallyFormat(format: "V:|-5-[v0]-5-|", views: signalTypeLabel)
        visuallyFormat(format: "V:|-5-[v0]-5-|", views: wifiStrengthButton)
        visuallyFormat(format: "V:|-5-[v0]-5-|", views: dateLabel)
        visuallyFormat(format: "V:|-5-[v0]-5-|", views: batteryImageView)
        visuallyFormat(format: "V:|-5-[v0]-5-|", views: chargingImageView)
        visuallyFormat(format: "H:|-5-[v0(40)]-2-[v1]-2-[v2]-2-[v3(20)]", views: connectionStrengthImageView, carrierLabel, signalTypeLabel, wifiStrengthButton)
        addConstraint(NSLayoutConstraint(item: dateLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        visuallyFormat(format: "H:[v0(30)]-2-[v1(5)]-5-|", views: batteryImageView, chargingImageView)
        wifiStrengthButton.isHidden = true
        
    }
    
    let connectionStrengthImageView = ConnectionStrengthImageView()
    
    let carrierLabel = CarrierLabel()
    
    let signalTypeLabel = SignalTypeLabel()
    
    let wifiStrengthButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.darkGray
        return button
    }()
    
    let dateLabel = DateLabel()
    
    let batteryImageView = BatteryImageView()
    
    let chargingImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "ChargingIndicator")
        return view
    }()
}
