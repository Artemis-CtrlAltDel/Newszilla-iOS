//
//  CoreDataManager.swift
//  Bmo
//
//  Created by Bellaala Mohamed on 12/7/2023.
//

import Foundation
import CoreData

class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer
    static let shared = CoreDataManager()
    
    private init() {
        
        persistentContainer = NSPersistentContainer(name: "NewsModel")
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        persistentContainer.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unable to initialize with error : \(error)")
            }
        }
    }
}
