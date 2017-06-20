//
//  Chat.swift
//  Dummy Messager
//
//  Created by Sanford Wilson on 6/14/17.
//  Copyright © 2017 Sanford Wilson. All rights reserved.
//

import Foundation

class Chat: NSObject {

    var contactName: String?
   
    // have to learn how to import these images in-app
    var contactImageName: String?
    
    init(name: String, imageNamed: String?) {
        contactName = name
        contactImageName = imageNamed
    }
}
