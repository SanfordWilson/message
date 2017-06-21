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
            
            let entityNames = ["Chat","Message"]
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
            
            createMessage(withText: "Dash-dash, come over: I'm making pasta", onChat: janani, context: context, time: NSDate(timeIntervalSinceNow: -98465))
            createMessage(withText: "Sexy pasta", onChat: janani, context: context, time: NSDate())
            
            let sanford = NSEntityDescription.insertNewObject(forEntityName: "Chat", into: context) as! Chat
            sanford.contactName = "Sanford Wilson"
            sanford.contactImageName = "Sanford"
            
            createMessage(withText: "trip hip triple flip triple double triple double triple double flip triple double triple double triple double flip", onChat: sanford, context: context, time: NSDate(timeIntervalSinceNow: -96243))
            
            do { try context.save()
            } catch let err {
                print(err)
            }
        }
        
        loadMessages()
    }
    
    private func createMessage(withText text: String?, onChat chat: Chat, context: NSManagedObjectContext, time: NSDate) {
        let message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        message.text = text
        message.time = time
        message.chat = chat
        
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
}
