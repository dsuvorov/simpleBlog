//
// Created by VIPER
// Copyright (c) 2017 VIPER. All rights reserved.
//

import Foundation

class AddModuleInteractor: AddModuleInteractorInputProtocol {
    weak var presenter: AddModuleInteractorOutputProtocol?
    var APIDataManager: AddModuleAPIDataManagerInputProtocol?
    var localDatamanager: AddModuleLocalDataManagerInputProtocol?
    
    init() {}
    
    func addNewItem(item: AddModuleItem) {
        localDatamanager?.addPostToQueue(post: item)
        presenter?.closeAddInterface()
    }

}
