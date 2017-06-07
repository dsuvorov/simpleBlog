//
// Created by VIPER
// Copyright (c) 2017 VIPER. All rights reserved.
//

import Foundation

class ListModuleInteractor: ListModuleInteractorInputProtocol
{
    weak var presenter: ListModuleInteractorOutputProtocol?
    var APIDataManager: ListModuleAPIDataManagerInputProtocol?
    var localDatamanager: ListModuleLocalDataManagerInputProtocol?
    
    init() {}
    
    func viewHasBeenLoaded() {
        self.syncAddedData()
        self.showAllPosts()
        self.refreshDBData()
    }
    
    func showAllPosts() { // shows all the posts from DB
        if self.localDatamanager != nil {
            let objects = self.localDatamanager!.getAllPostsFromDB()
            self.presenter?.showPosts(objects: objects)
        }
    }
    
    func syncAddedData() { // tries to upload all not uploaded posts
        let sQueue = DispatchQueue(label: "ru.ip-suvorov.sync-queue",
                                   qos: .utility,
                                   target: nil)
        sQueue.async {
            if let itemsToUpload = self.localDatamanager?.getAllQueueFromDB() {
                for item in itemsToUpload {
                    self.APIDataManager?.uploadPost(post: item, success: {isSucceed in
                        if isSucceed {
                            self.localDatamanager?.removePostFromQueue(objectIdUri: item.objectIdURI)
                        }
                    })
                }
            }
        }  
    }
    
    func refreshDBData() { // gets all the posts from server, removes all DB rows that are aready uploaded, adds all the posts from the server to DB
        self.APIDataManager?.getPosts(result: {(allPosts) in
            if allPosts != nil {
                if allPosts!.count > 0 {
                    // removes all the posts from DB which does not need to be uploaded
                    self.localDatamanager?.removeAllPostsFromDB()
                    for (num, item) in allPosts!.enumerated() {
                        self.localDatamanager?.addPostToDB(post: item)
                        if num == allPosts!.count-1 { // last item has been processed
                            self.showAllPosts()
                        }
                    }
                }
            }
        })
    }
}
