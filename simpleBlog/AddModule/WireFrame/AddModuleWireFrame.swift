//
// Created by VIPER
// Copyright (c) 2017 VIPER. All rights reserved.
//

import Foundation
import UIKit

let AddModuleViewIdentifier = "AddModuleView"

class AddModuleWireFrame: AddModuleWireFrameProtocol {
    var addPresenter : AddModulePresenter?
    var presentedViewController : UIViewController?
    
    func presentAddInterfaceFromViewController(viewController: UIViewController) {
        // Generating module components
        let view: AddModuleViewProtocol = AddModuleView()
        let presenter: AddModulePresenterProtocol & AddModuleInteractorOutputProtocol = AddModulePresenter()
        let interactor: AddModuleInteractorInputProtocol = AddModuleInteractor()
        let APIDataManager: AddModuleAPIDataManagerInputProtocol = AddModuleAPIDataManager()
        let localDataManager: AddModuleLocalDataManagerInputProtocol = AddModuleLocalDataManager()
        // let wireFrame: AddModuleWireFrameProtocol = AddModuleWireFrame()
        
        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = self
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.APIDataManager = APIDataManager
        interactor.localDatamanager = localDataManager
        
        let addView = AddModuleWireFrame.addModuleViewFromStoryboard()
        addView.presenter = presenter
        presenter.view = addView
        
        viewController.navigationController?.show(addView, sender: nil)
        presentedViewController = viewController
    }
    
    func closeAddInterface() {
        presentedViewController?.navigationController?.popViewController(animated: true)
    }
    
    class func addModuleViewFromStoryboard() -> AddModuleView {
        let storyboard = mainStoryboard()
        let viewController = storyboard.instantiateViewController(withIdentifier: AddModuleViewIdentifier) as! AddModuleView
        return viewController
    }
    
    class func mainStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard
    }
}
