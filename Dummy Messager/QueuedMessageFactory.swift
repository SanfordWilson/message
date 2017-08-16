//
//  QueuedMessageFactory.swift
//  Dummy Messager
//
//  Created by Sanford Wilson on 8/16/17.
//  Copyright © 2017 Sanford Wilson. All rights reserved.
//

import CoreData

class QueuedMessageFactory {
    
    static func createQueuedMessage(withText text: String?, onChat chat: Chat, context: NSManagedObjectContext, queueOrder: Double, after: Int16=1, delay: Double=1) {
        let queuedMessage = NSEntityDescription.insertNewObject(forEntityName: "QueuedMessage", into: context) as! QueuedMessage
        queuedMessage.text = text
        queuedMessage.chat = chat
        queuedMessage.queueOrder = queueOrder
        queuedMessage.after = after
        queuedMessage.delay = delay
    }
}
