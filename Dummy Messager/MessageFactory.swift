//
//  MessageFactory.swift
//  Dummy Messager
//
//  Created by Sanford Wilson on 8/16/17.
//  Copyright © 2017 Sanford Wilson. All rights reserved.
//

import CoreData
import UIKit

class MessageFactory {

    static func createMessage(withText text: String?,
                              onChat chat: Chat,
                              time: NSDate,
                              isSender: Bool = false) -> Message {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        message.text = text
        message.time = time
        message.chat = chat
        message.isSender = isSender

        if !(chat.lastMessage != nil) || time.compare(chat.lastMessage!.time! as Date) == .orderedDescending {
            chat.lastMessage = message
        }

        do {
            try context.save()
        } catch let err {
            print(err)
        }

        return message
    }
}
