//
// Created by VIPER
// Copyright (c) 2017 VIPER. All rights reserved.
//

import Foundation

class AddModuleWireFrame: AddModuleWireFrameProtocol
{
    class func presentAddModuleModule(fromView view: AnyObject)
    {
        // Generating module components
        var view: AddModuleViewProtocol = AddModuleView()
        var presenter: protocol<AddModulePresenterProtocol, AddModuleInteractorOutputProtocol> = AddModulePresenter()
        var interactor: AddModuleInteractorInputProtocol = AddModuleInteractor()
        var APIDataManager: AddModuleAPIDataManagerInputProtocol = AddModuleAPIDataManager()
        var localDataManager: AddModuleLocalDataManagerInputProtocol = AddModuleLocalDataManager()
        var wireFrame: AddModuleWireFrameProtocol = AddModuleWireFrame()
        
        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.APIDataManager = APIDataManager
        interactor.localDatamanager = localDataManager
    }
}