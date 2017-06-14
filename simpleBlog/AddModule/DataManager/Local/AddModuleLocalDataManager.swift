//
// Created by VIPER
// Copyright (c) 2017 VIPER. All rights reserved.
//

import Foundation
import CoreData

class AddModuleLocalDataManager: LocalDataManagerCommon, AddModuleLocalDataManagerInputProtocol {
    override init() {}
    
    // add a post to queue (to be uploaded)
    func addPostToQueue(post: AddModuleItem) {
        let newPost = post
        newPost.id = 0
        newPost.isSynched = false
        super.addToDB(post: newPost)
    }
}
