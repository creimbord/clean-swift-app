//
//  MainRouter.swift
//  CleanSwiftApp
//
//  Created by Rodion Artyukhin on 28.09.2022.
//

import UIKit

protocol MainRoutingLogic {
    func routeToPath()
}

protocol MainDataPassing {
    var dataStore: MainDataStore? { get }
}

final class MainRouter: MainRoutingLogic, MainDataPassing {
    
    // MARK: - Properties
    weak var viewController: MainViewController?
    var dataStore: MainDataStore?
    
    // MARK: - MainRoutingLogic
    func routeToPath() {
        let pathViewController = Assembly.createPathScene()
        if var pathDataStore = pathViewController.router.dataStore {
            passDataToPath(destination: &pathDataStore)
            navigateToPath(destination: pathViewController)
        }
    }
    
    // MARK: - Navigation
    private func navigateToPath(destination: PathViewController) {
        viewController?.present(destination, animated: true)
    }
    
    // MARK: - Passing data
    private func passDataToPath(destination: inout PathDataStore) {
        destination.selectedIndex = dataStore?.selectedIndex
    }
}
