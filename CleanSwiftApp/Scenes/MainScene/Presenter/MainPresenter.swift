//
//  MainPresenter.swift
//  CleanSwiftApp
//
//  Created by Rodion Artyukhin on 28.09.2022.
//

import UIKit

protocol MainPresentationLogic: AnyObject {
    func presentUpdatedEmoji(_ response: MainModel.UpdateEmoji.Response)
}

final class MainPresenter: MainPresentationLogic {
    
    weak var viewController: MainDisplayLogic?
    
    func presentUpdatedEmoji(_ response: MainModel.UpdateEmoji.Response) {
        let viewModel = MainModel.UpdateEmoji.ViewModel(
            emoji: response.emoji,
            fontSize: 50
        )
        viewController?.displayEmoji(viewModel)
    }
}
