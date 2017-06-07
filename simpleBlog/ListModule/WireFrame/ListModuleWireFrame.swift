//
// Created by VIPER
// Copyright (c) 2017 VIPER. All rights reserved.
//

import Foundation

class ListModuleWireFrame: ListModuleWireFrameProtocol
{
    class func presentListModuleModule(fromView view: AnyObject)
    {
        // Generating module components
        let view: ListModuleViewProtocol = ListModuleView()
        let presenter: ListModulePresenterProtocol & ListModuleInteractorOutputProtocol = ListModulePresenter()
        let interactor: ListModuleInteractorInputProtocol = ListModuleInteractor()
        let APIDataManager: ListModuleAPIDataManagerInputProtocol = ListModuleAPIDataManager()
        let localDataManager: ListModuleLocalDataManagerInputProtocol = ListModuleLocalDataManager()
        let wireFrame: ListModuleWireFrameProtocol = ListModuleWireFrame()
        
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
