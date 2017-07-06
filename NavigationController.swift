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
    
    let connectionStrengthButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.black
        return button
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
        label.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
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
        label.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        return label
    }()
    
    let batteryImageButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.black
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createStatusBar()
    }
    
    func createStatusBar() {
        view.addSubview(statusBar)
        view.visuallyFormat(format: "H:|[v0]|", views: statusBar)
        view.visuallyFormat(format: "V:|[v0(20)]", views: statusBar)
        statusBar.addSubview(connectionStrengthButton)
        statusBar.addSubview(carrierLabel)
        statusBar.addSubview(signalTypeLabel)
        statusBar.addSubview(wifiStrengthButton)
        statusBar.addSubview(dateLabel)
        statusBar.addSubview(batteryImageButton)
        statusBar.visuallyFormat(format: "V:|-5-[v0]-5-|", views: connectionStrengthButton)
        statusBar.visuallyFormat(format: "V:|-5-[v0]-5-|", views: carrierLabel)
        statusBar.visuallyFormat(format: "V:|-5-[v0]-5-|", views: signalTypeLabel)
        statusBar.visuallyFormat(format: "V:|-5-[v0]-5-|", views: wifiStrengthButton)
        statusBar.visuallyFormat(format: "V:|-5-[v0]-5-|", views: dateLabel)
        statusBar.visuallyFormat(format: "V:|-5-[v0]-5-|", views: batteryImageButton)
        statusBar.visuallyFormat(format: "H:|-5-[v0(40)]-2-[v1]-2-[v2]-2-[v3(20)]", views: connectionStrengthButton, carrierLabel, signalTypeLabel, wifiStrengthButton)
        statusBar.addConstraint(NSLayoutConstraint(item: dateLabel, attribute: .centerX, relatedBy: .equal, toItem: statusBar, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        statusBar.visuallyFormat(format: "H:[v0(25)]-5-|", views: batteryImageButton)
    }
}
