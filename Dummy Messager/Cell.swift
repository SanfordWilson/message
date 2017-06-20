//
//  Cell.swift
//  Dummy Messager
//
//  Created by Sanford Wilson on 6/19/17.
//  Copyright © 2017 Sanford Wilson. All rights reserved.
//

import UIKit

class Cell: UICollectionViewCell {
    
    //default cell for subclassing
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        shapeCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func shapeCell() {
        backgroundColor = UIColor.black
    }
    
    func visuallyFormat(format: String, views: UIView...) {
        
        var viewsDict = [String:UIView]()
        for (index, view) in views.enumerated() {
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDict["v\(index)"] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDict))
    }
}

