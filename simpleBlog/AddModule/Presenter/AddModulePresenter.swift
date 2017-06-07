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
}