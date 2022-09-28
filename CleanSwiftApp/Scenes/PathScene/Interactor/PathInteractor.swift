//
//  PathInteractor.swift
//  CleanSwiftApp
//
//  Created by Rodion Artyukhin on 28.09.2022.
//

import Foundation

protocol PathBusinessLogic: AnyObject {
    func populateEmojis(_ request: PathModel.PopulateEmojis.Request)
    func selectEmoji(_ request: PathModel.SelectEmoji.Request)
}

protocol PathDataStore {
    var emojis: Emojis { get }
    var selectedEmoji: String? { get }
    var selectedIndex: IndexPath? { get set }
}

final class PathInteractor: PathDataStore {
    
    // MARK: - Properties
    var presenter: PathPresentationLogic?
    
    // MARK: - PathDataStore
    private(set) var emojis: Emojis = []
    private(set) var selectedEmoji: String?
    var selectedIndex: IndexPath?
    
}

// MARK: - PathBusinessLogic
extension PathInteractor: PathBusinessLogic {
    func populateEmojis(_ request: PathModel.PopulateEmojis.Request) {
        let emojis: Emojis = {
            request.emojis.map { emoji in
                var icon = ""
                
                switch emoji {
                case .thoughtful: icon = "🤔"
                case .developer: icon = "👨‍💻"
                case .designer: icon = "🧑‍🎨"
                case .qa: icon = "🤷"
                case .analyst: icon = "🧐"
                case .pm: icon = "🧑‍💼"
                case .po: icon = "👨‍💼"
                }
                
                return (emoji: icon, profession: emoji.rawValue)
            }
        }()
        
        let response = PathModel.PopulateEmojis.Response(emojis: emojis)
        
        self.emojis = emojis
        presenter?.presentPopulatedEmojis(response)
    }
    
    func selectEmoji(_ request: PathModel.SelectEmoji.Request) {
        if let selectedIndex = selectedIndex {
            presenter?.presentSelectedEmoji(.init(index: selectedIndex))
        }
        selectedIndex = request.index
        selectedEmoji = emojis[request.index.item].emoji
        presenter?.presentSelectedEmoji(.init(index: request.index))
    }
}
