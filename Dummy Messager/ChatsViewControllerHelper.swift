//
//  ChatsViewControllerHelper.swift
//  Dummy Messager
//
//  Created by Sanford Wilson on 6/20/17.
//  Copyright © 2017 Sanford Wilson. All rights reserved.
//

import UIKit
import CoreData

extension ChatsViewController {

    func wipeMessages() {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        if let context = delegate?.persistentContainer.viewContext {
            
            let entityNames = ["Chat", "Message", "QueuedMessage"]
            for entityName in entityNames {
                
                let request = NSFetchRequest<NSManagedObject>(entityName: entityName)
                do {
                    let results = try context.fetch(request)
                    for result in results {
                        context.delete(result)
                    }
                    try context.save()
                } catch let err {
                    print(err)
                }
            }
        }
    }
    
    func makeFriends() {
        
        wipeMessages()
        let delegate = UIApplication.shared.delegate as? AppDelegate
        if let context = delegate?.persistentContainer.viewContext {
            
            let janani = NSEntityDescription.insertNewObject(forEntityName: "Chat", into: context) as! Chat
            janani.contactName = "Janani Lee"
            janani.contactImageName = "Janani"
            
            let _ = ChatsViewController.createMessage(withText: "Dash-dash, come over: I'm making pasta", onChat: janani, context: context, time: NSDate(timeIntervalSinceNow: -98465))
            let _ = ChatsViewController.createMessage(withText: "Sexy pasta?", onChat: janani, context: context, time: NSDate(), isSender: true)
            
            let sanford = NSEntityDescription.insertNewObject(forEntityName: "Chat", into: context) as! Chat
            sanford.contactName = "Sanford Wilson"
            sanford.contactImageName = "Sanford"
            
            let _ = ChatsViewController.createMessage(withText: "trip hip triple flip triple double triple double triple double flip triple double triple double triple double flip", onChat: sanford, context: context, time: NSDate(timeIntervalSinceNow: -96243))
            let _ = ChatsViewController.createMessage(withText: "trip hip triple flip triple double triple double triple double flip triple double triple double triple double flip", onChat: sanford, context: context, time: NSDate(timeIntervalSinceNow: -96243))
            let _ = ChatsViewController.createMessage(withText: "trip hip triple flip triple double triple double triple double flip triple double triple double triple double flip", onChat: sanford, context: context, time: NSDate(timeIntervalSinceNow: -96243))
            let _ = ChatsViewController.createMessage(withText: "trip hip triple flip triple double triple double triple double flip triple double triple double triple double flip", onChat: sanford, context: context, time: NSDate(timeIntervalSinceNow: -96243))
            let _ = ChatsViewController.createMessage(withText: "trip hip triple flip triple double triple double triple double flip triple double triple double triple double flip", onChat: sanford, context: context, time: NSDate(timeIntervalSinceNow: -96243))
            let _ = ChatsViewController.createMessage(withText: "trip hip triple flip triple double triple double triple double flip triple double triple double triple double flip", onChat: sanford, context: context, time: NSDate(timeIntervalSinceNow: -96243))
            let _ = ChatsViewController.createMessage(withText: "trip hip triple flip triple double triple double triple double flip triple double triple double triple double flip", onChat: sanford, context: context, time: NSDate(timeIntervalSinceNow: -96243))
            let _ = ChatsViewController.createMessage(withText: "trip hip triple flip triple double triple double triple double flip triple double triple double triple double flip", onChat: sanford, context: context, time: NSDate(timeIntervalSinceNow: -96243))
            ChatsViewController.createQueuedMessage(withText: "First queued message. Next one will come after 2 texts with a 5 second delay", onChat: sanford, context: context, queueOrder: 0)
            ChatsViewController.createQueuedMessage(withText: "Second queued message", onChat: sanford, context: context, queueOrder: 10, after: 2, delay: 5)
            ChatsViewController.createQueuedMessage(withText: "This is the third queued message and it comes after the last one with no input", onChat: sanford, context: context, queueOrder: 20, after: 0)
            do { try context.save()
            } catch let err {
                print(err)
            }
        }
    }
    
    static func createQueuedMessage(withText text: String?, onChat chat: Chat, context: NSManagedObjectContext, queueOrder: Double, after: Int16=1, delay: Double=1) {
        let queuedMessage = NSEntityDescription.insertNewObject(forEntityName: "QueuedMessage", into: context) as! QueuedMessage
        queuedMessage.text = text
        queuedMessage.chat = chat
        queuedMessage.queueOrder = queueOrder
        queuedMessage.after = after
        queuedMessage.delay = delay
    }
    
    static func createMessage(withText text: String?, onChat chat: Chat, context: NSManagedObjectContext, time: NSDate, isSender: Bool = false) -> Message {
        let message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        message.text = text
        message.time = time
        message.chat = chat
        message.isSender = isSender
        
        if !(chat.lastMessage != nil) || time.compare(chat.lastMessage!.time! as Date) == .orderedDescending {
            chat.lastMessage = message
        }
        return message
    }
    
    func fetchChats() -> [Chat]? {
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            let context = delegate.persistentContainer.viewContext
            let request: NSFetchRequest<Chat> = Chat.fetchRequest()
            do {
                return try context.fetch(request)
            } catch {
                return nil
            }
        }
        return nil
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
