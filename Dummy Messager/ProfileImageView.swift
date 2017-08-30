//
//  ProfileImageView.swift
//  Dummy Messager
//
//  Created by Sanford Wilson on 8/22/17.
//  Copyright © 2017 Sanford Wilson. All rights reserved.
//

import UIKit

class ProfileImageView: UIImageView {

    required init?(coder aDecoder: NSCoder) {
        fatalError("oops")
    }

    init(radius: CGFloat) {
        super.init(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        contentMode = .scaleAspectFill
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }

    func setCornerRadius(_ radius: CGFloat) {
        layer.cornerRadius = radius
    }
}
