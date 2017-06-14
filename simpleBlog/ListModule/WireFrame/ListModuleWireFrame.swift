//
// Created by VIPER
// Copyright (c) 2017 VIPER. All rights reserved.
//

import Foundation
import UIKit

let ListModuleViewIdentifier = "ListModuleView"

class ListModuleWireFrame: ListModuleWireFrameProtocol {
    static var presentedViewController: ListModuleView?
    
    func presentListModuleFromWindow(window: UIWindow) {
        let view: ListModuleViewProtocol = ListModuleView()
        let presenter: ListModulePresenterProtocol & ListModuleInteractorOutputProtocol = ListModulePresenter()
        let interactor: ListModuleInteractorInputProtocol = ListModuleInteractor()
        let APIDataManager: ListModuleAPIDataManagerInputProtocol = ListModuleAPIDataManager()
        let localDataManager: ListModuleLocalDataManagerInputProtocol = ListModuleLocalDataManager()
        let wireFrame: ListModuleWireFrameProtocol = ListModuleWireFrame()
        let rootWireframe: RootWireframe? = RootWireframe()
        
        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.APIDataManager = APIDataManager
        interactor.localDatamanager = localDataManager
        
        let listView = listModuleViewFromStoryboard()
        listView.presenter = presenter
        presenter.view = listView
        rootWireframe?.showRootViewController(viewController: listView, inWindow: window)
        ListModuleWireFrame.presentedViewController = listView
    }
    
    func presentAddModule() {
        let addModuleWireFrame : AddModuleWireFrame? = AddModuleWireFrame()
        addModuleWireFrame?.presentAddInterfaceFromViewController(viewController: ListModuleWireFrame.presentedViewController!)
    }
    
    func listModuleViewFromStoryboard() -> ListModuleView {
        let storyboard = mainStoryboard()
        let viewController = storyboard.instantiateViewController(withIdentifier: ListModuleViewIdentifier) as! ListModuleView
        return viewController
    }
    
    func mainStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard
    }
}

