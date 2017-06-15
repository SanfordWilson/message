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
    var sampleData = [String]()
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        if let lable = cell.textLabel {
            lable.text = sampleData[indexPath.row]
        }
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0..<100 {
            sampleData.append("Cell \(i)")
        }
    }
    
}
