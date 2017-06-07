//
// Created by VIPER
// Copyright (c) 2017 VIPER. All rights reserved.
//

import Foundation

protocol AddModuleViewProtocol: class
{
    var presenter: AddModulePresenterProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> VIEW
    */
}

protocol AddModuleWireFrameProtocol: class
{
    class func presentAddModuleModule(fromView view: AnyObject)
    /**
    * Add here your methods for communication PRESENTER -> WIREFRAME
    */
}

protocol AddModulePresenterProtocol: class
{
    var view: AddModuleViewProtocol? { get set }
    var interactor: AddModuleInteractorInputProtocol? { get set }
    var wireFrame: AddModuleWireFrameProtocol? { get set }
    /**
    * Add here your methods for communication VIEW -> PRESENTER
    */
}

protocol AddModuleInteractorOutputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> PRESENTER
    */
}

protocol AddModuleInteractorInputProtocol: class
{
    var presenter: AddModuleInteractorOutputProtocol? { get set }
    var APIDataManager: AddModuleAPIDataManagerInputProtocol? { get set }
    var localDatamanager: AddModuleLocalDataManagerInputProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> INTERACTOR
    */
}

protocol AddModuleDataManagerInputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> DATAMANAGER
    */
}

protocol AddModuleAPIDataManagerInputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> APIDATAMANAGER
    */
}

protocol AddModuleLocalDataManagerInputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> LOCALDATAMANAGER
    */
}
