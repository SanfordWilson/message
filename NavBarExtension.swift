//
//  NavBarExtension.swift
//  Dummy Messager
//
//  Created by Sanford Wilson on 6/29/17.
//  Copyright © 2017 Sanford Wilson. All rights reserved.
//

import UIKit

extension UINavigationBar {
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        let screenRect = UIScreen.main.bounds
        return CGSize(width: screenRect.size.width, height: 64)
    }
}
