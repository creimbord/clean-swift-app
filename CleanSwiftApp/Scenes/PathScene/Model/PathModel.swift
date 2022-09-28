//
//  PathModel.swift
//  CleanSwiftApp
//
//  Created by Rodion Artyukhin on 28.09.2022.
//

import Foundation
import CoreGraphics

enum PathModel {
    
    /// Populates profession emojis
    enum PopulateEmojis {
        struct Request {
            let emojis: [Emoji]
        }
        
        struct Response {
            let emojis: Emojis
        }
        
        struct ViewModel {
            let emojis: Emojis
        }
    }
    
    /// Selects the concrete emoji
    enum SelectEmoji {
        struct Request {
            let index: IndexPath
        }
        
        struct Response {
            let index: IndexPath
        }
        
        struct ViewModel {
            let index: IndexPath
        }
    }
}

typealias Emojis = [(emoji: String, profession: String)]
