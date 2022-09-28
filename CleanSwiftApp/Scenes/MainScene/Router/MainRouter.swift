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
        print("routing to path...")
    }
}
