//
//  Assembly.swift
//  CleanSwiftApp
//
//  Created by Rodion Artyukhin on 28.09.2022.
//

import Foundation

enum Assembly {
    static func createMainScene() -> MainViewController {
        let router = MainRouter()
        let presenter = MainPresenter()
        let interactor = MainInteractor()
        let viewController = MainViewController()
        
        interactor.presenter = presenter
        router.dataStore = interactor
        router.viewController = viewController
        presenter.viewController = viewController
        viewController.router = router
        viewController.interactor = interactor
        
        return viewController
    }
    
    static func createPathScene() -> PathViewController {
        let router = PathRouter()
        let presenter = PathPresenter()
        let interactor = PathInteractor()
        let viewController = PathViewController()
        
        interactor.presenter = presenter
        router.dataStore = interactor
        router.viewController = viewController
        presenter.viewController = viewController
        viewController.router = router
        viewController.interactor = interactor
        
        return viewController
    }
}
