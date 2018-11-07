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

            _ = MessageFactory.makeMessage(withText: "Dash-dash, come over: I'm making pasta",
              onChat: janani, time: NSDate(timeIntervalSinceNow: -98465))
            _ = MessageFactory.makeMessage(withText: "Sexy pasta?", onChat: janani, time: NSDate(), isSender: true)

            let sanford = NSEntityDescription.insertNewObject(forEntityName: "Chat", into: context) as! Chat
            sanford.contactName = "Sanford Wilson"
            sanford.contactImageName = "Sanford"

            _ = MessageFactory.makeMessage(withText:
              "trip hip triple flip triple double triple double triple double flip triple double triple double triple double flip",
              onChat: sanford, time: NSDate(timeIntervalSinceNow: -86243))
            _ = MessageFactory.makeMessage(withText:
              "trip hip triple flip triple double triple double triple double flip triple double triple double triple double flip",
              onChat: sanford, time: NSDate(timeIntervalSinceNow: -96243))
            _ = MessageFactory.makeMessage(withText:
              "trip hip triple flip triple double triple double triple double flip triple double triple double triple double flip",
              onChat: sanford, time: NSDate(timeIntervalSinceNow: -76243))
            _ = MessageFactory.makeMessage(withText:
              "trip hip triple flip triple double triple double triple double flip triple double triple double triple double flip",
              onChat: sanford, time: NSDate(timeIntervalSinceNow: -66243))
            _ = MessageFactory.makeMessage(withText:
              "trip hip triple flip triple double triple double triple double flip triple double triple double triple double flip",
              onChat: sanford, time: NSDate(timeIntervalSinceNow: -56243))
            _ = MessageFactory.makeMessage(withText:
              "trip hip triple flip triple double triple double triple double flip triple double triple double triple double flip",
              onChat: sanford, time: NSDate(timeIntervalSinceNow: -46243))
            _ = MessageFactory.makeMessage(withText:
              "trip hip triple flip triple double triple double triple double flip triple double triple double triple double flip",
              onChat: sanford, time: NSDate(timeIntervalSinceNow: -6243))
            _ = MessageFactory.makeMessage(withText:
              "trip hip triple flip triple double triple double triple double flip triple double triple double triple double flip",
              onChat: sanford, time: NSDate(timeIntervalSinceNow: -243))
            QueuedMessageFactory.makeQueuedMessage(withText:
              "First queued message. Next one will come after 2 texts with a 5 second delay",
              onChat: sanford, queueOrder: 0)
            QueuedMessageFactory.makeQueuedMessage(withText:
              "Second queued message",
              onChat: sanford, queueOrder: 10, after: 2, delay: 5)
            QueuedMessageFactory.makeQueuedMessage(withText:
              "This is the third queued message and it comes after the last one with no input",
              onChat: sanford, queueOrder: 20, after: 0)
            do { try context.save()
            } catch let err {
                print(err)
            }
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
