//
//  MainInteractor.swift
//  CleanSwiftApp
//
//  Created by Rodion Artyukhin on 28.09.2022.
//

import Foundation

protocol MainBusinessLogic: AnyObject {
    func updateEmoji(_ request: MainModel.UpdateEmoji.Request)
}

protocol MainDataStore {
    var selectedEmoji: String? { get set }
    var selectedIndex: IndexPath? { get set }
}

final class MainInteractor: MainDataStore {
    
    // MARK: - Properties
    var presenter: MainPresentationLogic?
    
    // MARK: - MainDataStore
    var selectedIndex: IndexPath?
    var selectedEmoji: String? {
        didSet { updateEmoji(.init(emoji: .selected)) }
    }
    
}

// MARK: - MainBusinessLogic
extension MainInteractor: MainBusinessLogic {
    func updateEmoji(_ request: MainModel.UpdateEmoji.Request) {
        let emoji: String = getEmoji(by: request.emoji)
        let response = MainModel.UpdateEmoji.Response(emoji: emoji)
        presenter?.presentUpdatedEmoji(response)
    }
    
    private func getEmoji(by type: EmojiType) -> String {
        switch type {
        case .name(let emoji):
            switch emoji {
            case .thoughtful: return "🤔"
            case .developer: return "👨‍💻"
            case .designer: return "🧑‍🎨"
            case .qa: return "🤷"
            case .analyst: return "🧐"
            case .pm: return "🧑‍💼"
            case .po: return "👨‍💼"
            }
        case .selected:
            return selectedEmoji ?? "🤔"
        }
    }
}
