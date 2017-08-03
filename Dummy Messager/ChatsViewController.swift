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
    TODO: special settings cell?
    TODO: Custom Back Button
    TODO: New Message Button
    TODO: Whatever that left hand button is
    */
    
    lazy var chatsFetchController: NSFetchedResultsController = { () -> NSFetchedResultsController<Chat> in
        let delegate = UIApplication.shared.delegate as? AppDelegate
        let context = delegate?.persistentContainer.viewContext
        let request: NSFetchRequest<Chat> = Chat.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "lastMessage.time", ascending: false)]
        let controller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context!, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        return controller
    }()
    
    lazy var blockOperations = [BlockOperation]()
    
    
//    var messages: [Message]?
    
//    func loadMessages() {
//        
//        messages = [Message]()
//        
//        if let Chats = fetchChats() {
//            for chat in Chats {
//                let delegate = UIApplication.shared.delegate as? AppDelegate
//                if let context = delegate?.persistentContainer.viewContext {
//                    let request: NSFetchRequest<Message> = Message.fetchRequest()
//                    request.sortDescriptors = [NSSortDescriptor(key: "time", ascending: false)]
//                    request.predicate = NSPredicate(format: "chat.contactName = %@", chat.contactName!)
//                    request.fetchLimit = 1
//                    
//                    do {
//                        let fetchedMessage = try context.fetch(request)
//                        messages?.append(contentsOf: fetchedMessage)
//                    } catch let err {
//                        print(err)
//                    }
//                }
//            }
//            //there's gotta be a better way to do this
//            messages?.sort(by: {$0.time!.compare($1.time! as Date) == .orderedDescending})
//        }
//    }
    
    private let chatsCellIdentifier = "reuse me broh"
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Messages"
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(ChatCell.self, forCellWithReuseIdentifier: chatsCellIdentifier)
        collectionView?.alwaysBounceVertical = true
        makeFriends()
        
        do {
            try chatsFetchController.performFetch()
        } catch let err {
            print(err)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = chatsFetchController.sections?[section].numberOfObjects {
            return count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let chatCell = collectionView.dequeueReusableCell(withReuseIdentifier: chatsCellIdentifier, for: indexPath) as! ChatCell
        
        let chat = chatsFetchController.object(at: indexPath)
        chatCell.message = chat.lastMessage
        return chatCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let layout = UICollectionViewFlowLayout()
        let controller = ConversationViewController(collectionViewLayout: layout)
        let chat = chatsFetchController.object(at: indexPath)
        controller.chat = chat
        navigationController?.pushViewController(controller, animated: true)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView?.collectionViewLayout.invalidateLayout()
    }
}
