//
//  RootWireFrame.swift
//  simpleBlog
//
//  Created by Dmitry Suvorov on 08/06/17.
//  Copyright © 2017 ip-suvorov. All rights reserved.
//

import Foundation
import UIKit

class RootWireframe : NSObject {
    func showRootViewController(viewController: UIViewController, inWindow: UIWindow) {
        let navigationController = navigationControllerFromWindow(window: inWindow)
        navigationController.viewControllers = [viewController]
    }
    
    func navigationControllerFromWindow(window: UIWindow) -> UINavigationController {
        let navigationController = window.rootViewController as! UINavigationController
        return navigationController
    }
    
    func showListModuleFromWindow(window: UIWindow) {
        let listModuleWireFrame : ListModuleWireFrame? = ListModuleWireFrame()
        listModuleWireFrame?.presentListModuleFromWindow(window: window)
    }
}
