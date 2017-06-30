//
//  ConversationViewControllerHelper.swift
//  Dummy Messager
//
//  Created by Sanford Wilson on 6/28/17.
//  Copyright © 2017 Sanford Wilson. All rights reserved.
//

import UIKit
import Foundation

extension ConversationViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "ℹ︎", style: .plain, target: self, action: #selector(simulateMessage))
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(MessageCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView?.alwaysBounceVertical = true
        
        view.addSubview(messageInputView)
        view.visuallyFormat(format: "H:|[v0]|", views: messageInputView)
        view.visuallyFormat(format: "V:[v0(40)]", views: messageInputView)
        setupInput()
        bottomConstraint = NSLayoutConstraint(item: messageInputView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        view.addConstraint(bottomConstraint!)
        self.collectionView?.scrollToItem(at: IndexPath(item: (self.messages?.count)! - 1, section: 0), at: .bottom, animated: false)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: .UIKeyboardWillHide, object: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        inputTextField.endEditing(true)
    }
    
    func simulateMessage() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        let newMessage = ChatsViewController.createMessage(withText: "poooo", onChat: chat!, context: context, time: NSDate(timeIntervalSinceNow: -2000))
        
        do {
            try context.save()
            
            messages?.append(newMessage)
            messages = messages?.sorted(by: {$0.time!.compare($1.time! as Date) == .orderedDescending})
            
            if let item = messages?.index(of: newMessage) {
                let path = IndexPath(item: item, section: 0)
                collectionView?.insertItems(at: [path])
            }
        } catch let err {
            print(err)
        }
    }

    func handleKeyboard(notification: Notification) {
        if let userInfo = notification.userInfo {
            let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect
            
            let isKeyboardVisible = notification.name == .UIKeyboardWillShow
            
            bottomConstraint?.constant = isKeyboardVisible ? -(keyboardFrame?.height)! : 0.0
            
            UIView.animate(withDuration: 0, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                
                self.view.layoutIfNeeded()
            }, completion: {(completed) in
                
                if isKeyboardVisible {
                    self.collectionView?.scrollToItem(at: IndexPath(item: (self.messages?.count)! - 1, section: 0), at: .bottom, animated: true)
                }
            })
        }
    }
    
    
    private func setupInput() {
        messageInputView.contentView.addSubview(inputTextField)
        messageInputView.contentView.addSubview(inputTextFieldSendButton)
        messageInputView.contentView.visuallyFormat(format: "H:|-20-[v0]-10-[v1(20)]-10-|", views: inputTextField, inputTextFieldSendButton)
        messageInputView.contentView.visuallyFormat(format: "V:|-5-[v0]-5-|", views: inputTextField)
        messageInputView.contentView.addConstraint(NSLayoutConstraint(item: inputTextFieldSendButton, attribute: .centerY, relatedBy: .equal, toItem: inputTextField, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        messageInputView.contentView.addConstraint(NSLayoutConstraint(item: inputTextFieldSendButton, attribute: .height, relatedBy: .equal, toItem: inputTextFieldSendButton, attribute: .width, multiplier: 1.0, constant: 0.0))
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
