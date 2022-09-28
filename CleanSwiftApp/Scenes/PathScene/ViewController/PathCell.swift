//
//  PathCell.swift
//  CleanSwiftApp
//
//  Created by Rodion Artyukhin on 28.09.2022.
//

import UIKit

final class PathCell: UICollectionViewCell {
    
    // MARK: - Views
    let emojiView: EmojiView = {
        let emoji = EmojiView(style: .medium)
        emoji.isUserInteractionEnabled = false
        emoji.label.font = .systemFont(ofSize: 30)
        return emoji
    }()
    let professionlabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        label.backgroundColor = .white
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(emojiView)
        contentView.addSubview(professionlabel)
    }
    
    @available(*, unavailable) required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        let labelOffset = CGFloat(15)
        let labelSize = professionlabel.intrinsicContentSize
        
        emojiView.frame = CGRect(origin: .zero, size: emojiView.style.size)
        emojiView.center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        
        professionlabel.frame = CGRect(
            x: (bounds.width - labelSize.width) / 2,
            y: emojiView.frame.origin.y + emojiView.frame.height + labelOffset,
            width: labelSize.width,
            height: labelSize.height
        )
    }
}
