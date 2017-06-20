//
//  File.swift
//  Dummy Messager
//
//  Created by Sanford Wilson on 6/14/17.
//  Copyright © 2017 Sanford Wilson. All rights reserved.
//

import UIKit
import CoreData

class ChatsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    /* First point of contact for user, displays list of chats
    will need to figure out how to permanently attach special settings cell*/
    
    //also, is this where I'll add the buttons, or will I do that in the nav controller subclass?
    
    var messages: [Message]?
    
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
    
    func loadMessages() {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        if let context = delegate?.persistentContainer.viewContext {
            let request = NSFetchRequest<NSManagedObject>(entityName: "Message")
            
            do {
             messages = try context.fetch(request) as? [Message]
            } catch let err {
                print(err)
            }
        }
    }
    
    private let chatsCellIdentifier = "reuse me broh"
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Messages"
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(ChatCell.self, forCellWithReuseIdentifier: chatsCellIdentifier)
        collectionView?.alwaysBounceVertical = true
        makeFriends()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let messageCounter = messages {
            return messageCounter.count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let chatCell = collectionView.dequeueReusableCell(withReuseIdentifier: chatsCellIdentifier, for: indexPath) as! ChatCell
        if let message = messages?[indexPath.item] {
            chatCell.message = message
        }
        
        return chatCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
}
