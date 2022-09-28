//
//  MainViewController.swift
//  CleanSwiftApp
//
//  Created by Rodion Artyukhin on 28.09.2022.
//

import UIKit

protocol MainDisplayLogic: AnyObject {
    func displayEmoji(_ viewModel: MainModel.UpdateEmoji.ViewModel)
}

final class MainViewController: UIViewController {
    
    // MARK: - Properties
    var router: (MainRoutingLogic & MainDataPassing)!
    var interactor: MainBusinessLogic!
    
    // MARK: - Constants
    private enum Constants {
        static let buttonWidth: CGFloat = 250
        static let buttonHeight: CGFloat = 36
        static let buttonTopOffset: CGFloat = 30
    }
    
    // MARK: - Views
    private let emojiView = EmojiView(style: .large)
    private lazy var selectButton: UIButton = {
        var button = UIButton()
        button.layer.cornerRadius = 18
        button.backgroundColor = Color.blue
        button.titleLabel?.backgroundColor = Color.blue
        button.setTitle("Choose your path", for: .normal)
        button.addTarget(self, action: #selector(selectButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life cycle
    override func loadView() {
        super.loadView()
        setupViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.updateEmoji(.init(emoji: .name(.thoughtful)))
    }
    
    @objc private func selectButtonTapped() {
        router.routeToPath()
    }
}

// MARK: - MainBusinessLogic
extension MainViewController: MainDisplayLogic {
    func displayEmoji(_ viewModel: MainModel.UpdateEmoji.ViewModel) {
        emojiView.label.text = viewModel.emoji
        emojiView.label.font = .systemFont(ofSize: viewModel.fontSize)
    }
}

// MARK: - Setup views
private extension MainViewController {
    func setupViews() {
        addSubviews()
        setupFrames()
        view.backgroundColor = .white
    }
    
    func addSubviews() {
        view.addSubview(emojiView)
        view.addSubview(selectButton)
    }
    
    func setupFrames() {
        let bounds = UIScreen.main.bounds
        let emojiWidth = emojiView.style.size.width
        let emojiHeight = emojiView.style.size.height
        
        emojiView.frame = CGRect(
            x: (bounds.width - emojiWidth) / 2,
            y: (bounds.height - emojiHeight - Constants.buttonTopOffset - Constants.buttonHeight) / 2,
            width: emojiWidth,
            height: emojiHeight
        )
        selectButton.frame = CGRect(
            x: (bounds.width - Constants.buttonWidth) / 2,
            y: emojiView.frame.origin.y + emojiHeight + Constants.buttonTopOffset,
            width: Constants.buttonWidth,
            height: Constants.buttonHeight
        )
    }
}
