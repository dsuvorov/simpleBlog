//
// Created by VIPER
// Copyright (c) 2017 VIPER. All rights reserved.
//

import Foundation
import CoreData

class ListModuleLocalDataManager: LocalDataManagerCommon, ListModuleLocalDataManagerInputProtocol
{
    override init() {}
    
    // gets all posts from DB
    func getAllPostsFromDB()->([ListModuleItem]) {
        let items = super.getFromDB(predictArray: nil)
        return self.convertToListItem(from: items)
    }
    
    // adds a post from server to db
    func addPostToDB(post: ListModuleItem) {
        let newPost = post
        newPost.isSynched = true
        super.addToDB(post: newPost)
    }
    
    // removes all the posts from DB except unsynched (not uploaded)
    func removeAllPostsFromDB() {
        let predictArray = ["is_synched == true"]
        super.deleteFromDB(predictArray: predictArray)
    }
    
    // get all posts to be uploaded from DB
    func getAllQueueFromDB()->([ListModuleItem]) {
        let predictArray = ["is_synched == false"]
        let items = super.getFromDB(predictArray: predictArray)
        return self.convertToListItem(from: items)
    }
    
    // removes the post from the queue
    func removePostFromQueue(objectIdUri: URL) {
        if let objectId: NSManagedObjectID = super.persistentStoreCoordinator.managedObjectID(forURIRepresentation: objectIdUri) {
            let obj = super.managedObjectContext.object(with: objectId) as! PostRecords
            obj.is_synched = true
            super.saveContext()
        }
    }
    
    func convertToListItem(from: [DataItem])->([ListModuleItem]) {
        let itemsIn = from
        var itemsOut = [ListModuleItem]()
        for itIn in itemsIn {
            let itOut = ListModuleItem(id: itIn.id, date: itIn.date, name: itIn.name, body: itIn.body, userPicUrl: itIn.userPicUrl)
            itOut.objectIdURI = itIn.objectIdURI
            itemsOut.append(itOut)
        }
        return itemsOut
    }
}
