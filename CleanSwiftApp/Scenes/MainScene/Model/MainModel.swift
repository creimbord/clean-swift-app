//
//  MainModel.swift
//  CleanSwiftApp
//
//  Created by Rodion Artyukhin on 28.09.2022.
//

import Foundation
import CoreGraphics

enum MainModel {
    
    /// Updates emoji based on user choice
    enum UpdateEmoji {
        struct Request {
            let emoji: EmojiType
        }
        
        struct Response {
            let emoji: String
        }
        
        struct ViewModel {
            let emoji: String
            let fontSize: CGFloat
        }
    }
}

enum Emoji: String, CaseIterable {
    case thoughtful = "Thoughtful"
    case developer = "Developer"
    case designer = "Designer"
    case qa = "QA"
    case analyst = "Analyst"
    case pm = "PM"
    case po = "PO"
}

enum EmojiType {
    case name(Emoji)
    case selected
}
