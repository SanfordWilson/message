//
//  ConversationViewController.swift
//  Dummy Messager
//
//  Created by Sanford Wilson on 6/20/17.
//  Copyright © 2017 Sanford Wilson. All rights reserved.
//

import UIKit

class ConversationViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var currentKeyboardHeight: CGFloat = 0
    let reuseIdentifier = "I'm a message cell, broh"
    var messages: [Message]?
    var queuedMessages: [QueuedMessage]?
    var chat: Chat? {
        didSet {
            navigationItem.title = chat?.contactName?.components(separatedBy: " ")[0]
            messages = chat?.messages?.allObjects as? [Message]
            messages?.sort(by: {$0.time!.compare($1.time! as Date) == .orderedAscending})
            queuedMessages = chat?.queuedMessages?.allObjects as? [QueuedMessage]
            queuedMessages?.sort(by: {$0.queueOrder < $1.queueOrder})
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
            let size = CGSize(width: 250, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let frameEstimate = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 18)], context: nil)

            if !message.isSender {
                cell.textView.frame = CGRect(x: MessageCell.profilePictureRadius*4+5, y: 0, width: frameEstimate.width + 15, height: frameEstimate.height + 20)
                cell.bubbleView.frame = CGRect(x: MessageCell.profilePictureRadius*4, y: 0.0, width: frameEstimate.width + 15 + 5, height: frameEstimate.height + 20)
                cell.bubbleView.backgroundColor = UIColor(white: 0.9, alpha: 1)
                cell.textView.textColor = UIColor.darkText
                cell.profilePictureView.isHidden = false
                if let contactImage = message.chat?.contactImageName {
                    cell.profilePictureView.image = UIImage(named: contactImage)
                }
            } else {
                cell.textView.frame = CGRect(x: view.frame.width - frameEstimate.width - 15 - 10, y: 0, width: frameEstimate.width + 15, height: frameEstimate.height + 20)
                cell.bubbleView.frame = CGRect(x: view.frame.width - frameEstimate.width - 20 - 10, y: 0.0, width: frameEstimate.width + 15 + 5, height: frameEstimate.height + 20)
                cell.bubbleView.backgroundColor = UIColor.blue
                cell.textView.textColor = UIColor.white
                cell.profilePictureView.isHidden = true
            }
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
        return UIEdgeInsetsMake(8, 0, 48, 0)
    }
    
}
