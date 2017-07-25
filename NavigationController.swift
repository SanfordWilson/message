//
//  NavigationController.swift
//  Dummy Messager
//
//  Created by Sanford Wilson on 6/29/17.
//  Copyright © 2017 Sanford Wilson. All rights reserved.
//

import UIKit


class NavigationController: UINavigationController {
    
    let statusBar: UIView = {
        let bar = UIView()
        return bar
    }()
    
    let connectionStrengthImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "ConnectionLevel4")
        return view
    }()
    
    let carrierLabel: UILabel = {
        let label = UILabel()
        label.text = "Carrier"
        label.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        return label
    }()
    
    let signalTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "LTE"
        label.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize, weight: UIFontWeightThin)
        return label
    }()
    
    let wifiStrengthButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.darkGray
        return button
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        let currentTime = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        label.text = formatter.string(from: currentTime)
        label.font = UIFont.boldSystemFont(ofSize: UIFont.smallSystemFontSize)
        return label
    }()
    
    let batteryImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "BatteryFull")
        return view
    }()
    
    let chargingImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "ChargingIndicator")
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createStatusBar()
    }
    
    func createStatusBar() {
        view.addSubview(statusBar)
        view.visuallyFormat(format: "H:|[v0]|", views: statusBar)
        view.visuallyFormat(format: "V:|[v0(20)]", views: statusBar)
        statusBar.addSubview(connectionStrengthImage)
        statusBar.addSubview(carrierLabel)
        statusBar.addSubview(signalTypeLabel)
        statusBar.addSubview(wifiStrengthButton)
        statusBar.addSubview(dateLabel)
        statusBar.addSubview(batteryImageView)
        statusBar.addSubview(chargingImageView)
        statusBar.visuallyFormat(format: "V:|-5-[v0]-5-|", views: connectionStrengthImage)
        statusBar.visuallyFormat(format: "V:|-5-[v0]-5-|", views: carrierLabel)
        statusBar.visuallyFormat(format: "V:|-5-[v0]-5-|", views: signalTypeLabel)
        statusBar.visuallyFormat(format: "V:|-5-[v0]-5-|", views: wifiStrengthButton)
        statusBar.visuallyFormat(format: "V:|-5-[v0]-5-|", views: dateLabel)
        statusBar.visuallyFormat(format: "V:|-5-[v0]-5-|", views: batteryImageView)
        statusBar.visuallyFormat(format: "V:|-5-[v0]-5-|", views: chargingImageView)
        statusBar.visuallyFormat(format: "H:|-5-[v0(40)]-2-[v1]-2-[v2]-2-[v3(20)]", views: connectionStrengthImage, carrierLabel, signalTypeLabel, wifiStrengthButton)
        statusBar.addConstraint(NSLayoutConstraint(item: dateLabel, attribute: .centerX, relatedBy: .equal, toItem: statusBar, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        statusBar.visuallyFormat(format: "H:[v0(20)]-2-[v1(5)]-5-|", views: batteryImageView, chargingImageView)
        wifiStrengthButton.isHidden = true
    }
}
