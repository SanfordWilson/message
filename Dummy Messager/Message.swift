//
//  Message.swift
//  Dummy Messager
//
//  Created by Sanford Wilson on 6/14/17.
//  Copyright © 2017 Sanford Wilson. All rights reserved.
//

import Foundation

class Message: NSObject {
    
    var text: String?
    var time: Date?
    var chat: Chat?
    
    //should delay times go with the sender? We'll figure more out as we go
    
    init(text: String, sentAt time: Date, onThread chat: Chat) {
        self.text = text
        self.time = time
        self.chat = chat
    }
}
