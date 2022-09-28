//
//  EmojiView.swift
//  CleanSwiftApp
//
//  Created by Rodion Artyukhin on 28.09.2022.
//

import UIKit

final class EmojiView: UIControl {
    
    // MARK: - Properties
    enum Style {
        case large, medium
        
        var size: CGSize {
            switch self {
            case .large: return CGSize(width: 150, height: 150)
            case .medium: return CGSize(width: 100, height: 100)
            }
        }
        
        var cornerRadius: CGFloat {
            switch self {
            case .large: return 20
            case .medium: return 15
            }
        }
    }
    
    let style: Style
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? Color.blue : Color.gray
            label.backgroundColor = isSelected ? Color.blue : Color.gray
        }
    }
    
    // MARK: - Views
    let label: UILabel = {
        let label = UILabel()
        label.backgroundColor = Color.gray
        return label
    }()
    
    // MARK: - Init
    init(emoji: String = "🤔", style: Style) {
        self.style = style
        self.label.text = emoji
        super.init(frame: .zero)
        setupViews()
    }
    
    @available(*, unavailable) required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        setupFrames()
    }
    
}

// MARK: - Setup views
private extension EmojiView {
    func setupViews() {
        addSubviews()
        setupView()
    }
    
    func addSubviews() {
        addSubview(label)
    }
    
    func setupView() {
        backgroundColor = Color.gray
        layer.cornerRadius = style.cornerRadius
    }
    
    func setupFrames() {
        label.frame = CGRect(origin: .zero, size: label.intrinsicContentSize)
        label.center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
    }
}
