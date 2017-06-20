//
//  File.swift
//  Dummy Messager
//
//  Created by Sanford Wilson on 6/14/17.
//  Copyright © 2017 Sanford Wilson. All rights reserved.
//

import UIKit

class ChatsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    /* First point of contact for user, displays list of chats
    will need to figure out how to permanently attach special settings cell*/
    
    //also, is this where I'll add the buttons, or will I do that in the nav controller subclass?
    
    var messages: [Message]?
    
    func makeFriends() {
        let newChat = Chat(name:"Janani Lee", imageNamed: "Janani")
        let message = Message(text: "I'm gonna suck your Dashy dick, Dashiell Bat-for-a-dick Robb!", sentAt: Date.init(timeInterval: -100000, since: Date()), onThread: newChat)
        messages = [message]
        
        let newChat1 = Chat(name:"Sanford Wilson", imageNamed: nil)
        let message1 = Message(text: "Yo bro!", sentAt: Date.init(timeInterval: -1111000, since: Date()), onThread: newChat1)
        messages?.append(message1)
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
