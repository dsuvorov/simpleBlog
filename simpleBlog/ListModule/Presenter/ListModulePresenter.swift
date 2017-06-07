//
// Created by VIPER
// Copyright (c) 2017 VIPER. All rights reserved.
//

import Foundation

class ListModulePresenter: ListModulePresenterProtocol, ListModuleInteractorOutputProtocol
{
    weak var view: ListModuleViewProtocol?
    var interactor: ListModuleInteractorInputProtocol?
    var wireFrame: ListModuleWireFrameProtocol?
    
    init() {}
    
    func viewHasBeenLoaded() { // view has been loaded
        self.interactor?.viewHasBeenLoaded()
    }
    
    func showPosts(objects: [ListModuleItem]) {
        // gets posts from interactor and transforming data to view's format. In our case they are identical at this moment
        var tableItems = [TableViewItem]()
        for obj in objects {
            var item = TableViewItem(id: obj.id,
                                      date: obj.date,
                                      name: obj.name,
                                      body: obj.body,
                                      userPicUrl: obj.userPicUrl)
            item.isSynched = obj.isSynched
            item.objectIdURI = obj.objectIdURI
            
            tableItems.append(item)
        }
        // show the posts
        self.view?.showObjects(objects: tableItems)
    }
    
    func addBtnPressed() { // add button has been pressed
        
    }
    
}
