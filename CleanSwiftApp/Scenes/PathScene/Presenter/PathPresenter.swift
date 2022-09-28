//
//  PathPresenter.swift
//  CleanSwiftApp
//
//  Created by Rodion Artyukhin on 28.09.2022.
//

import UIKit

protocol PathPresentationLogic: AnyObject {
    func presentPopulatedEmojis(_ response: PathModel.PopulateEmojis.Response)
    func presentSelectedEmoji(_ response: PathModel.SelectEmoji.Response)
}

final class PathPresenter: PathPresentationLogic {
    
    weak var viewController: PathDisplayLogic?
    
    func presentPopulatedEmojis(_ response: PathModel.PopulateEmojis.Response) {
        let viewModel = PathModel.PopulateEmojis.ViewModel(emojis: response.emojis)
        viewController?.displayPopulatedEmojis(viewModel)
    }
    
    func presentSelectedEmoji(_ response: PathModel.SelectEmoji.Response) {
        let viewModel = PathModel.SelectEmoji.ViewModel(index: response.index)
        viewController?.displaySelectedEmoji(viewModel)
    }
}
