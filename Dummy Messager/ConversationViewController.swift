//
//  ConversationViewController.swift
//  Dummy Messager
//
//  Created by Sanford Wilson on 6/20/17.
//  Copyright © 2017 Sanford Wilson. All rights reserved.
//

import UIKit
import CoreData

class ConversationViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    /// Tracks keyboard for setting bottom edge insets
    var currentKeyboardHeight: CGFloat = 0.0
    let reuseIdentifier = "I'm a message cell, broh"
    var queuedMessages: [QueuedMessage]?
    
    /// Sets the number of messages to wait and delay time when a message is queued
    var nextMessage: QueuedMessage? {
        didSet {
            if let message = nextMessage {
                waitTime = message.delay
                waitForMessages = Int(message.after)
            }
        }
    }
    
    var waitTime: Double?
    
    /// Triggers the next queued message on a timer when set to 0
    var waitForMessages: Int? {
        didSet {
            if waitForMessages == 0 {
                Timer.scheduledTimer(timeInterval: waitTime ?? 0, target: self, selector: #selector(sendNextMessage), userInfo: nil, repeats: false)
            }
        }
    }
    
    var chat: Chat? {
        didSet {
            navigationItem.title = chat?.contactName?.components(separatedBy: " ")[0]
            queuedMessages = chat?.queuedMessages?.allObjects as? [QueuedMessage]
            queuedMessages?.sort(by: {$0.queueOrder > $1.queueOrder})
            nextMessage = queuedMessages?.popLast()
        }
    }
    
    var blockOperations = [BlockOperation]()
    
    lazy var messagesFetchController: NSFetchedResultsController = { () -> NSFetchedResultsController<Message> in
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let request: NSFetchRequest<Message> = Message.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "time", ascending: true)]
        request.predicate = NSPredicate(format: "chat = %@", self.chat!)
        let controller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        return controller
    }()
    
    /// Bottom bar for input field and buttons (with blur effect)
    let messageInputView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .regular)
        let view = UIVisualEffectView(effect: blurEffect)
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /// Where useer types out a message
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
        button.addTarget(self, action: #selector(sendNewMessageFromInput), for: .touchUpInside)
        return button
    }()
    
    ///Enters and displays a new message and scrolls to the bottom
    func newMessage(text: String?, isSender: Bool) {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let _ = MessageFactory.createMessage(withText: text, onChat: chat!, context: context, time: NSDate(), isSender: isSender)
        
        do {
            try context.save()
            try messagesFetchController.performFetch()
        } catch let err {
            print(err)
        }
        
        scrollToEnd(animated: true, plus: currentKeyboardHeight + messageInputView.frame.height + 5)
    }
    
    /// Enters and displays the currently queued QueuedMessage, and queues the next one if it exists
    func sendNextMessage() {
        if let message = nextMessage {
            newMessage(text: message.text, isSender: false)
            nextMessage = queuedMessages?.popLast()
        }
    }
    
    /// Sends message with text form input field, wipes field, and incriments waitForMessages by -1
    func sendNewMessageFromInput() {
        if let text = inputTextField.text {
            newMessage(text: text, isSender: true)
            inputTextField.text = nil
            waitForMessages? -= 1
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = messagesFetchController.sections?[0].numberOfObjects {
            return count
        }
        return 0
    }
    
    // Sets up the MessageCell using Message data. Should be refactored into MessageCell class and modified to allow proper resizing
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MessageCell
        
        let message = messagesFetchController.object(at: indexPath)
        cell.textView.text = message.text
        
        if let messageText = message.text {
            let size = CGSize(width: view.frame.width * 0.618, height: CGFloat.greatestFiniteMagnitude)
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
                cell.textView.frame = CGRect(x: view.frame.width - frameWidth - 15, y: 0, width: frameWidth, height: frameHeight)
                cell.bubbleView.frame = CGRect(x: view.frame.width - frameWidth - 25, y: 0.0, width: frameWidth + 15, height: frameHeight)
                cell.bubbleView.backgroundColor = UIColor.blue
                cell.textView.textColor = UIColor.white
                cell.bubbleImageView.image = UIImage(named: "RightChatBubble")?.withRenderingMode(.alwaysTemplate)
                cell.profilePictureView.isHidden = true
            }
        }
        
        return cell
    }
    
    // Sets MessageCell dimensions, some of this should be refactored into MessageCell class as well
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let messageText = messagesFetchController.object(at: indexPath).text {
            let size = CGSize(width: view.frame.width * 0.618, height: CGFloat.greatestFiniteMagnitude)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let frameEstimate = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 18)], context: nil)
            return CGSize(width: view.frame.width, height: frameEstimate.height+20 > 40 ? frameEstimate.height + 20 : 40)
        }
        return CGSize(width: view.frame.width, height:100)
    }
    
    // Sets default insets
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(8, 0, 48, 0)
    }
}
