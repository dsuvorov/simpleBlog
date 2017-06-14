//
// Created by VIPER
// Copyright (c) 2017 VIPER. All rights reserved.
//

import Foundation
import UIKit

protocol AddModuleViewProtocol: class {
    // methods for communication PRESENTER -> VIEW
    var presenter: AddModulePresenterProtocol? { get set }
    var imageUrlTextField: UITextField! { get }
    var userNameTextField: UITextField! { get }
    var textView: UITextView! { get }
    var datePicker: UIDatePicker! { get }
}

protocol AddModuleWireFrameProtocol: class {
    // methods for communication PRESENTER -> WIREFRAME
    func presentAddInterfaceFromViewController(viewController: UIViewController)
    func closeAddInterface()
}

protocol AddModulePresenterProtocol: class {
    // methods for communication VIEW -> PRESENTER
    var view: AddModuleViewProtocol? { get set }
    var interactor: AddModuleInteractorInputProtocol? { get set }
    var wireFrame: AddModuleWireFrameProtocol? { get set }
    
    func viewHasBeenLoaded()
    func saveBtnPressed()
}

protocol AddModuleInteractorOutputProtocol: class {
    // methods for communication INTERACTOR -> PRESENTER
    func closeAddInterface()
}

protocol AddModuleInteractorInputProtocol: class {
    // methods for communication PRESENTER -> INTERACTOR
    var presenter: AddModuleInteractorOutputProtocol? { get set }
    var APIDataManager: AddModuleAPIDataManagerInputProtocol? { get set }
    var localDatamanager: AddModuleLocalDataManagerInputProtocol? { get set }
    
    func addNewItem(item: AddModuleItem)
}

protocol AddModuleDataManagerInputProtocol: class {
    // methods for communication INTERACTOR -> DATAMANAGER
}

protocol AddModuleAPIDataManagerInputProtocol: class {
    // methods for communication INTERACTOR -> APIDATAMANAGER
}

protocol AddModuleLocalDataManagerInputProtocol: class {
    // methods for communication INTERACTOR -> LOCALDATAMANAGER
    func addPostToQueue(post: AddModuleItem)
}
