//
// Created by VIPER
// Copyright (c) 2017 VIPER. All rights reserved.
//

import Foundation
import UIKit

protocol AddModuleViewProtocol: class
{
    var presenter: AddModulePresenterProtocol? { get set }
    var imageUrlTextField: UITextField! { get }
    var userNameTextField: UITextField! { get }
    var textView: UITextView! { get }
    var datePicker: UIDatePicker! { get }
    /**
    * Add here your methods for communication PRESENTER -> VIEW
    */
//    var 
//    if view?.imageUrlTextField.text != "" && view?.userNameTextField.text != "" && view?.textView.text != "" {

}

protocol AddModuleWireFrameProtocol: class
{
    func presentAddInterfaceFromViewController(viewController: UIViewController)
    func closeAddInterface()
    // methods for communication PRESENTER -> WIREFRAME
}

protocol AddModulePresenterProtocol: class
{
    var view: AddModuleViewProtocol? { get set }
    var interactor: AddModuleInteractorInputProtocol? { get set }
    var wireFrame: AddModuleWireFrameProtocol? { get set }
    
    func viewHasBeenLoaded()
    func saveBtnPressed()
    /**
    * Add here your methods for communication VIEW -> PRESENTER
    */
}

protocol AddModuleInteractorOutputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> PRESENTER
    */
    func closeAddInterface()
}

protocol AddModuleInteractorInputProtocol: class
{
    var presenter: AddModuleInteractorOutputProtocol? { get set }
    var APIDataManager: AddModuleAPIDataManagerInputProtocol? { get set }
    var localDatamanager: AddModuleLocalDataManagerInputProtocol? { get set }
    
    func addNewItem(item: AddModuleItem)
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
    func addPostToQueue(post: AddModuleItem)
    // methods for communication INTERACTOR -> LOCALDATAMANAGER
}
