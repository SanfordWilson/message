//
//  MessageFactory.swift
//  Dummy Messager
//
//  Created by Sanford Wilson on 8/16/17.
//  Copyright © 2017 Sanford Wilson. All rights reserved.
//

import CoreData

class MessageFactory {
    
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
}
