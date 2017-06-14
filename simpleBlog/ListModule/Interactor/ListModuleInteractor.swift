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
    
    func viewHasBeenLoaded() {}
    
    func viewWillBeShown() {
        self.syncAddedData()
        self.showAllPosts() // show from DB
        self.refreshDBData(completion: {() in self.showAllPosts()}) // update DB with server's data and show it
    }
    
    func refreshCalled() {
        presenter?.startRefreshingActivity()
        self.refreshDBData(completion: {() in
            self.showAllPosts()
            self.presenter?.stopRefreshingActivity()
        })
    }
    
    func showAllPosts() { // shows all the posts from DB
        if localDatamanager != nil {
            let objects = localDatamanager!.getAllPostsFromDB()
            presenter?.showPosts(objects: objects)
        }
    }
    
    func syncAddedData() { // tries to upload all not uploaded posts
        if let itemsToUpload = localDatamanager?.getAllQueueFromDB() { // dispatches in .service queue (see the method implementation (getAllQueueFromDB()) with Alamofire)
            for item in itemsToUpload {
                APIDataManager?.uploadPost(post: item, success: {isSucceed in
                    if isSucceed && item.objectIdURI != nil {
                        self.localDatamanager?.removePostFromQueue(objectIdUri: item.objectIdURI!)
                    }
                })
            }
        }
    }
    
    func refreshDBData(completion: @escaping ()->()) { // gets all the posts from server, removes all DB rows that are aready uploaded, adds all the posts from the server to DB
        APIDataManager?.getPosts(result: {(allPosts) in
            if allPosts != nil {
                if allPosts!.count > 0 {
                    // removes all the posts from DB which does not need to be uploaded
                    self.localDatamanager?.removeAllPostsFromDB()
                    for (num, item) in allPosts!.enumerated() {
                        self.localDatamanager?.addPostToDB(post: item)
                        if num == allPosts!.count-1 { // last item has been processed
                            completion()
                        }
                    }
                }
            }
        })
    }
}
