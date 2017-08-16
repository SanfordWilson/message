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
            
            let _ = MessageFactory.createMessage(withText: "Dash-dash, come over: I'm making pasta", onChat: janani, context: context, time: NSDate(timeIntervalSinceNow: -98465))
            let _ = MessageFactory.createMessage(withText: "Sexy pasta?", onChat: janani, context: context, time: NSDate(), isSender: true)
            
            let sanford = NSEntityDescription.insertNewObject(forEntityName: "Chat", into: context) as! Chat
            sanford.contactName = "Sanford Wilson"
            sanford.contactImageName = "Sanford"
            
            let _ = MessageFactory.createMessage(withText: "trip hip triple flip triple double triple double triple double flip triple double triple double triple double flip", onChat: sanford, context: context, time: NSDate(timeIntervalSinceNow: -96243))
            let _ = MessageFactory.createMessage(withText: "trip hip triple flip triple double triple double triple double flip triple double triple double triple double flip", onChat: sanford, context: context, time: NSDate(timeIntervalSinceNow: -96243))
            let _ = MessageFactory.createMessage(withText: "trip hip triple flip triple double triple double triple double flip triple double triple double triple double flip", onChat: sanford, context: context, time: NSDate(timeIntervalSinceNow: -96243))
            let _ = MessageFactory.createMessage(withText: "trip hip triple flip triple double triple double triple double flip triple double triple double triple double flip", onChat: sanford, context: context, time: NSDate(timeIntervalSinceNow: -96243))
            let _ = MessageFactory.createMessage(withText: "trip hip triple flip triple double triple double triple double flip triple double triple double triple double flip", onChat: sanford, context: context, time: NSDate(timeIntervalSinceNow: -96243))
            let _ = MessageFactory.createMessage(withText: "trip hip triple flip triple double triple double triple double flip triple double triple double triple double flip", onChat: sanford, context: context, time: NSDate(timeIntervalSinceNow: -96243))
            let _ = MessageFactory.createMessage(withText: "trip hip triple flip triple double triple double triple double flip triple double triple double triple double flip", onChat: sanford, context: context, time: NSDate(timeIntervalSinceNow: -96243))
            let _ = MessageFactory.createMessage(withText: "trip hip triple flip triple double triple double triple double flip triple double triple double triple double flip", onChat: sanford, context: context, time: NSDate(timeIntervalSinceNow: -96243))
            QueuedMessageFactory.createQueuedMessage(withText: "First queued message. Next one will come after 2 texts with a 5 second delay", onChat: sanford, context: context, queueOrder: 0)
            QueuedMessageFactory.createQueuedMessage(withText: "Second queued message", onChat: sanford, context: context, queueOrder: 10, after: 2, delay: 5)
            QueuedMessageFactory.createQueuedMessage(withText: "This is the third queued message and it comes after the last one with no input", onChat: sanford, context: context, queueOrder: 20, after: 0)
            do { try context.save()
            } catch let err {
                print(err)
            }
        }
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
