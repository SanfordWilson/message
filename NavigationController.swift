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
        bar.backgroundColor = UIColor.cyan
        return bar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createStatusBar()
    }
    
    func createStatusBar() {
        view.addSubview(statusBar)
        view.visuallyFormat(format: "H:|[v0]|", views: statusBar)
        view.visuallyFormat(format: "V:|[v0(20)]", views: statusBar)
    }
}
