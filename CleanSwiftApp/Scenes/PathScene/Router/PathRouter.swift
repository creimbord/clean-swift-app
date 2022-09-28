//
//  PathRouter.swift
//  CleanSwiftApp
//
//  Created by Rodion Artyukhin on 28.09.2022.
//

import UIKit

protocol PathRoutingLogic {
    func routeToMain()
}

protocol PathDataPassing {
    var dataStore: PathDataStore? { get }
}

final class PathRouter: PathRoutingLogic, PathDataPassing {
    
    // MARK: - Properties
    weak var viewController: PathViewController?
    var dataStore: PathDataStore?
    
    // MARK: - MainRoutingLogic
    func routeToMain() {
        let mainViewController = viewController?.presentingViewController as? MainViewController
        if var mainDataStore = mainViewController?.router.dataStore {
            passDataToMain(destination: &mainDataStore)
            navigateToMain()
        }
    }
    
    // MARK: - Navigation
    private func navigateToMain() {
        viewController?.dismiss(animated: true)
    }
    
    // MARK: - Passing data
    private func passDataToMain(destination: inout MainDataStore) {
        destination.selectedEmoji = dataStore?.selectedEmoji
        destination.selectedIndex = dataStore?.selectedIndex
    }
}
