//
//  DynamicCollectionViewFlowLayout.swift
//  Dummy Messager
//
//  Created by Sanford Wilson on 8/31/17.
//  Copyright © 2017 Sanford Wilson. All rights reserved.
//

import CoreData
import UIKit

class FetchControllerFactory {

  enum FetchType {
    case chats
    case messages
  }

  static func create(fetchType: FetchType,
                     delegate: NSFetchedResultsControllerDelegate,
                     predicate: NSPredicate? = nil) -> NSFetchedResultsController<NSFetchRequestResult> {

    let delegate = UIApplication.shared.delegate as? AppDelegate
    let context = delegate?.persistentContainer.viewContext
    
    let request = fetchType == .chats ? Chat.fetchRequest() : Message.fetchRequest()

    switch fetchType {

    case .chats:
      request.sortDescriptors = [NSSortDescriptor(key: "lastMessage.time", ascending: false)]

    case .messages:
      request.sortDescriptors = [NSSortDescriptor(key: "time", ascending: true)]
    }

    if let requestPredicate = predicate {
      request.predicate = requestPredicate
    }

    let controller = NSFetchedResultsController(fetchRequest: request,
      managedObjectContext: context!, sectionNameKeyPath: nil, cacheName: nil)
    controller.delegate = delegate as? NSFetchedResultsControllerDelegate
    return controller
  }
}
