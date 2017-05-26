//
//  MyDB.swift - Singleton working with Core Data
//  simpleBlog
//
//  Created by Dmitry Suvorov on 24/05/17.
//  Copyright © 2017 ip-suvorov. All rights reserved.
//

import UIKit
import CoreData

struct postSctruct {
    var id: Int
    var date: Date
    var name: String
    var body: String?
    var userPicUrl: String?
    var isSynched: Bool = false
    var objectId: NSManagedObjectID?

    init(id: Int, date: Date, name: String, body: String?, userPicUrl: String?) { // initialize with only these props
        self.id = id
        self.date = date
        self.name = name
        self.body = body
        self.userPicUrl = userPicUrl
    }
}

// MARK: - Singleton
final class MyDB {
    
    private init() { }
    static let sharedInstance = MyDB()
    
    // gets all posts from DB
    public func getAllPosts()->([postSctruct]) {
        return self.getFromDB(predictArray: nil)
    }
    
    // adds a post from server to db
    public func addPostToDB(post: postSctruct) {
        var newPost = post
        newPost.isSynched = true
        self.addToDB(post: newPost)
    }
    
    // removes all the posts from DB except unsynched (not uploaded)
    public func removeAllPosts() {
        let predictArray = ["is_synched == true"]
        self.deleteFromDB(predictArray: predictArray)
    }
    
    // get all posts to be uploaded from DB
    public func getAllQueue()->([postSctruct]) {
        let predictArray = ["is_synched == false"]
        return self.getFromDB(predictArray: predictArray)
    }
    
    // add a post to queue (to be uploaded)
    public func addPostToQueue(post: postSctruct) {
        var newPost = post
        newPost.id = 0
        newPost.isSynched = false
        self.addToDB(post: post)
    }
    
    // removes the post from the queue
    public func removePostFromQueue(objectId: NSManagedObjectID) {
        let obj = self.managedObjectContext.object(with: objectId) as! PostRecords
        obj.is_synched = true
        self.saveContext()
    }
    
    // adds a post to db - general
    private func addToDB(post: postSctruct) {
        let newPostRec = PostRecords()
        
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
    private func deleteFromDB(predictArray: [String]?)->() {
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

    // gets from db - general
    private func getFromDB(predictArray: [String]?)->([postSctruct]) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PostRecords")
        if predictArray != nil {
            for pred in predictArray! {
                fetchRequest.predicate = NSPredicate(format: pred)
            }
        }
        
        let sortSync = NSSortDescriptor(key: #keyPath(PostRecords.is_synched), ascending: true)
        let sortID = NSSortDescriptor(key: #keyPath(PostRecords.date), ascending: false)
        fetchRequest.sortDescriptors = [sortSync, sortID]
        
        var resultArray = [postSctruct]()
        do {
            let results = try self.managedObjectContext.fetch(fetchRequest)
            for result in results as! [PostRecords] {
                var post = postSctruct(id: Int(result.id),
                                       date: result.date!,
                                       name: result.name!,
                                       body: result.body,
                                       userPicUrl: result.user_pic_url)
                post.isSynched = result.is_synched
                post.objectId = result.objectID
                
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
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    // MARK: - Core Data Saving support
    func saveContext () {
        let sQueue = DispatchQueue(label: "ru.ip-suvorov.sync-queue",
                                   qos: .utility,
                                   target: nil)
        sQueue.sync {
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
}


