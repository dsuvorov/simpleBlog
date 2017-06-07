//
// Created by VIPER
// Copyright (c) 2017 VIPER. All rights reserved.
//

import Foundation

protocol ListModuleViewProtocol: class
{
    var presenter: ListModulePresenterProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> VIEW
    */
    func showObjects(objects:[TableViewItem])
}

protocol ListModuleWireFrameProtocol: class
{
    static func presentListModuleModule(fromView view: AnyObject)
    /**
    * Add here your methods for communication PRESENTER -> WIREFRAME
    */
}

protocol ListModulePresenterProtocol: class
{
    var view: ListModuleViewProtocol? { get set }
    var interactor: ListModuleInteractorInputProtocol? { get set }
    var wireFrame: ListModuleWireFrameProtocol? { get set }
    /**
    * Add here your methods for communication VIEW -> PRESENTER
    */
    func viewHasBeenLoaded()
    func addBtnPressed()
}

protocol ListModuleInteractorOutputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> PRESENTER
    */
    func showPosts(objects: [ListModuleItem])
}

protocol ListModuleInteractorInputProtocol: class
{
    var presenter: ListModuleInteractorOutputProtocol? { get set }
    var APIDataManager: ListModuleAPIDataManagerInputProtocol? { get set }
    var localDatamanager: ListModuleLocalDataManagerInputProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> INTERACTOR
    */
    func viewHasBeenLoaded()
}

protocol ListModuleDataManagerInputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> DATAMANAGER
    */
}

protocol ListModuleAPIDataManagerInputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> APIDATAMANAGER
    */
    func getPosts(result: @escaping([ListModuleItem]?)->())
    func uploadPost(post: ListModuleItem, success: @escaping(Bool)->())
}

protocol ListModuleLocalDataManagerInputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> LOCALDATAMANAGER
    */
    func addPostToDB(post: ListModuleItem)
    func getAllPostsFromDB()->[ListModuleItem]
    func getAllQueueFromDB()->[ListModuleItem]
    func removePostFromQueue(objectIdUri: URL)
    func removeAllPostsFromDB()
}
