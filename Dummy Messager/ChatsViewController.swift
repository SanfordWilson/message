//
//  File.swift
//  Dummy Messager
//
//  Created by Sanford Wilson on 6/14/17.
//  Copyright © 2017 Sanford Wilson. All rights reserved.
//

import UIKit

class ChatsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
    private let chatsCellIdentifier = "reuse me broh"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Messages"
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(ChatCell.self, forCellWithReuseIdentifier: chatsCellIdentifier)
        collectionView?.alwaysBounceVertical = true
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: chatsCellIdentifier, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
}

class ChatCell: Cell {
    
    let dividerLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        return view
    }()
    
    override func shapeCell() {
        backgroundColor = UIColor.blue
        addSubview(dividerLine)
        dividerLine.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-82-[v0]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": dividerLine]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(10)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": dividerLine]))
        
    }
}

class Cell: UICollectionViewCell {
    
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

    
}
