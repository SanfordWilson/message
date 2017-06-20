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
            
            let message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
            message.text = "hey Dash, you coming over tonight???"
            message.time = NSDate(timeIntervalSinceNow: -100000)
            message.chat = janani
            //messages = [message]
            
            let sanford = NSEntityDescription.insertNewObject(forEntityName: "Chat", into: context) as! Chat
            sanford.contactName = "Sanford Wilson"
            sanford.contactImageName = "Sanford"
            
            
            let message1 = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
            message1.text = "triple double triple double triple double flip"
            message1.time = NSDate(timeIntervalSinceNow: -2389562)
            message1.chat = sanford
            //messages?.append(message1)
            
            do { try context.save()
            } catch let err {
                print(err)
            }
        }
        
        loadMessages()
    }
}
