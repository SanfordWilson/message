//
//  File.swift
//  Dummy Messager
//
//  Created by Sanford Wilson on 6/14/17.
//  Copyright © 2017 Sanford Wilson. All rights reserved.
//

import Foundation
import UIKit

class ChatsTableViewController: UITableViewController {
    
    let cellReuseIdentifier = "ChatCell"
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}
