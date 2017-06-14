//
//  localDataManagerCommon.swift
//  simpleBlog
//
//  Created by Dmitry Suvorov on 14/06/17.
//  Copyright © 2017 ip-suvorov. All rights reserved.
//

import Foundation
import CoreData

class LocalDataManagerCommon: NSObject {
    
    //////////////////////////////////////////////////////////////////////////////////////
    // MARK: DB General methods
    // adds a post to db - general
    func addToDB(post: DataItem) {
        let newPostRec = PostRecords(MOC: managedObjectContext)
        
        newPostRec.id = Int16(post.id)
        newPostRec.name = post.name
        newPostRec.date = post.date
        newPostRec.is_synched = post.isSynched
        if post.body != nil {
            newPostRec.body = post.body!
        }
        if post.userPicUrl != nil {
            newPostRec.user_pic_url = post.userPicUrl
        }
        self.saveContext()
    }
    
    // removes from db - general
    func deleteFromDB(predictArray: [String]?)->() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PostRecords")
        if predictArray != nil {
            for pred in predictArray! {
                fetchRequest.predicate = NSPredicate(format: pred)
            }
        }
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try self.managedObjectContext.execute(deleteRequest)
            self.saveContext()
        }
        catch let error as NSError {
            print(error)
        }
    }
    
    func removePostFromQueue(objectIdUri: URL) {
        if let objectId: NSManagedObjectID = self.persistentStoreCoordinator.managedObjectID(forURIRepresentation: objectIdUri) {
            let obj = self.managedObjectContext.object(with: objectId) as! PostRecords
            obj.is_synched = true
            self.saveContext()
        }
    }
    
    // gets from db - general
    func getFromDB(predictArray: [String]?)->([DataItem]) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PostRecords")
        if predictArray != nil {
            for pred in predictArray! {
                fetchRequest.predicate = NSPredicate(format: pred)
            }
        }
        
        let sortSync = NSSortDescriptor(key: #keyPath(PostRecords.is_synched), ascending: true)
        let sortID = NSSortDescriptor(key: #keyPath(PostRecords.date), ascending: false)
        fetchRequest.sortDescriptors = [sortSync, sortID]
        
        var resultArray = [DataItem]()
        do {
            let results = try self.managedObjectContext.fetch(fetchRequest)
            for result in results as! [PostRecords] {
                let post = DataItem(id: Int(result.id),
                                          date: result.date!,
                                          name: result.name!,
                                          body: result.body,
                                          userPicUrl: result.user_pic_url)
                post.isSynched = result.is_synched
                post.objectIdURI = result.objectID.uriRepresentation()
                
                resultArray.append(post)
            }
        } catch {
            print(error)
        }
        return resultArray
    }
    
    
    //////////////////////////////////////////////////////////////////////////////////////
    // MARK: - Core Data stack
    lazy var applicationDocumentsDirectory: NSURL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1] as NSURL
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: "simpleBlog", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("simpleBlog.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    // MARK: - Core Data Saving support
    func saveContext () {
        if self.managedObjectContext.hasChanges {
            do {
                try self.managedObjectContext.save()
            } catch {
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
}
