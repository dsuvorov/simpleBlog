//
// Created by VIPER
// Copyright (c) 2017 VIPER. All rights reserved.
//

import Foundation

class AddModulePresenter: AddModulePresenterProtocol, AddModuleInteractorOutputProtocol
{
    weak var view: AddModuleViewProtocol?
    var interactor: AddModuleInteractorInputProtocol?
    var wireFrame: AddModuleWireFrameProtocol?
    
    init() {}
    
    func viewHasBeenLoaded() {
    }
    
    func saveBtnPressed() {
        if view != nil && view!.imageUrlTextField.text != "" && view!.userNameTextField.text != "" && view!.textView.text != "" {
            let item = AddModuleItem(id: 0, date: view!.datePicker.date, name: view!.userNameTextField.text!, body: view!.textView.text, userPicUrl: view!.imageUrlTextField.text)
            interactor?.addNewItem(item: item)
        }
    }
    
    func closeAddInterface() {
        wireFrame?.closeAddInterface()
    }
}
