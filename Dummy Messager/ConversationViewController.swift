//
//  ConversationViewController.swift
//  Dummy Messager
//
//  Created by Sanford Wilson on 6/20/17.
//  Copyright © 2017 Sanford Wilson. All rights reserved.
//

import UIKit

class ConversationViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var currentKeyboardHeight: CGFloat = 0.0
    let reuseIdentifier = "I'm a message cell, broh"
    var messages: [Message]?
    var chat: Chat? {
        didSet {
            navigationItem.title = chat?.contactName?.components(separatedBy: " ")[0]
            messages = chat?.messages?.allObjects as? [Message]
            messages?.sort(by: {$0.time!.compare($1.time! as Date) == .orderedAscending})
        }
    }
    
    let messageInputView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .regular)
        let view = UIVisualEffectView(effect: blurEffect)
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let inputTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "iMessage"
        field.borderStyle = .roundedRect
        return field
    }()
    
    
    var bottomConstraint: NSLayoutConstraint?
    
    lazy var inputTextFieldSendButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("↑", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.backgroundColor = UIColor.darkGray
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(sendNewMessage), for: .touchUpInside)
        return button
    }()
    
    func sendNewMessage() {

        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let newMessage = ChatsViewController.createMessage(withText: inputTextField.text, onChat: chat!, context: context, time: NSDate(), isSender: true)
        
        do {
            try context.save()
            messages?.append(newMessage)
            let path = IndexPath(item: messages!.count - 1, section: 0)
            collectionView?.insertItems(at: [path])
            //collectionView?.scrollToItem(at: path, at: .bottom, animated: true)
            
            inputTextField.text = nil
        } catch let err {
            print(err)
        }
        
        scrollToEnd(animated: true, plus: currentKeyboardHeight + messageInputView.frame.height + 5)
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
        
        if let message = messages?[indexPath.item], let messageText = message.text {
            let size = CGSize(width: 220, height: CGFloat.greatestFiniteMagnitude)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let frameEstimate = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 18)], context: nil)
            let frameWidth = frameEstimate.width + 15 > 43 ? frameEstimate.width + 15 : 43
            let frameHeight = frameEstimate.height + 20 > 40 ? frameEstimate.height + 20 : 40
            if !message.isSender {
                cell.textView.frame = CGRect(x: MessageCell.profilePictureRadius*3+15, y: 0, width: frameWidth, height: frameHeight)
                cell.bubbleView.frame = CGRect(x: MessageCell.profilePictureRadius*3, y: 0.0, width: frameWidth + 15, height: frameHeight)
                cell.bubbleView.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
                cell.textView.textColor = UIColor.darkText
                cell.profilePictureView.isHidden = false
                cell.bubbleImageView.image = UIImage(named: "LeftChatBubble")?.withRenderingMode(.alwaysTemplate)
                if let contactImage = message.chat?.contactImageName {
                    cell.profilePictureView.image = UIImage(named: contactImage)
                }
            } else {
                cell.textView.frame = CGRect(x: view.frame.width - frameWidth - 20, y: 0, width: frameWidth, height: frameHeight)
                cell.bubbleView.frame = CGRect(x: view.frame.width - frameWidth - 25, y: 0.0, width: frameWidth + 15, height: frameHeight)
                cell.bubbleView.backgroundColor = UIColor.blue
                cell.textView.textColor = UIColor.white
                cell.bubbleImageView.image = UIImage(named: "RightChatBubble")?.withRenderingMode(.alwaysTemplate)
                cell.profilePictureView.isHidden = true
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let messageText = messages?[indexPath.item].text {
            let size = CGSize(width: 220, height: CGFloat.greatestFiniteMagnitude)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let frameEstimate = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 18)], context: nil)
            return CGSize(width: view.frame.width, height: frameEstimate.height+20 > 40 ? frameEstimate.height + 20 : 40)
        }
        return CGSize(width: view.frame.width, height:100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(8, 0, 48, 0)
    }
    
}
