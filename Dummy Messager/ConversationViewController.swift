//
//  ConversationViewController.swift
//  Dummy Messager
//
//  Created by Sanford Wilson on 6/20/17.
//  Copyright © 2017 Sanford Wilson. All rights reserved.
//

import UIKit

class ConversationViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let reuseIdentifier = "I'm a message cell, broh"
    var messages: [Message]?
    var chat: Chat? {
        didSet {
            navigationItem.title = chat?.contactName
            messages = chat?.messages?.allObjects as? [Message]
            messages?.sort(by: {$0.time!.compare($1.time! as Date) == .orderedAscending})
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(MessageCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView?.alwaysBounceVertical = true
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = messages?.count {
            return count
        } else {
            return 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MessageCell
        cell.textView.text = messages?[indexPath.item].text
        
        if let messageText = messages?[indexPath.item].text {
            let size = CGSize(width: 250, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let frameEstimate = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 18)], context: nil)

            cell.textView.frame = CGRect(x: MessageCell.profilePictureRadius*4+5, y: 0, width: frameEstimate.width + 15, height: frameEstimate.height + 20)
            cell.bubbleView.frame = CGRect(x: MessageCell.profilePictureRadius*4, y: 0.0, width: frameEstimate.width + 15 + 5, height: frameEstimate.height + 20)
        }
        
        if let contactImage = messages?[indexPath.item].chat?.contactImageName {
            cell.profilePictureView.image = UIImage(named: contactImage)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let messageText = messages?[indexPath.item].text {
            let size = CGSize(width: 250, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let frameEstimate = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 18)], context: nil)
            return CGSize(width: view.frame.width, height: frameEstimate.height+20)
        }
        return CGSize(width: view.frame.width, height:100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(8, 0, 0, 0)
    }
    
}
