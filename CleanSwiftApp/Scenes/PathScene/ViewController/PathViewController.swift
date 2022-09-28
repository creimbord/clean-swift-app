//
//  PathViewController.swift
//  CleanSwiftApp
//
//  Created by Rodion Artyukhin on 28.09.2022.
//

import UIKit

protocol PathDisplayLogic: AnyObject {
    func displayPopulatedEmojis(_ viewModel: PathModel.PopulateEmojis.ViewModel)
    func displaySelectedEmoji(_ viewModel: PathModel.SelectEmoji.ViewModel)
}

final class PathViewController: UIViewController {
    
    // MARK: - Properties
    var router: (PathRoutingLogic & PathDataPassing)!
    var interactor: (PathBusinessLogic & PathDataStore)!
    private var emojis: Emojis = []
    
    // MARK: - Constants
    private enum Constants {
        static let screenWidth = UIScreen.main.bounds.width
        static let screenHeight = UIScreen.main.bounds.height
        static let buttonWidth: CGFloat = 250
        static let buttonHeight: CGFloat = 36
        static let sideOffset = (screenWidth - 2 * cellSize.width) / 3
        static let collectionViewHeight = cellSize.height * 3 + 50
        static let cellSize = CGSize(width: screenWidth * 0.26, height: screenHeight * 0.2)
    }
    
    // MARK: - Views
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 15
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(
            PathCell.self,
            forCellWithReuseIdentifier: String(describing: PathCell.self)
        )
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    private lazy var confirmButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = Color.blue
        button.layer.cornerRadius = 18
        button.setTitle("Confirm", for: .normal)
        button.addTarget(
            self,
            action: #selector(confirmButtonTapped),
            for: .touchUpInside
        )
        return button
    }()
    
    // MARK: - Life cycle
    override func loadView() {
        super.loadView()
        setupViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.populateEmojis(.init(emojis: [
            .developer, .designer, .qa, .analyst, .pm, .po
        ]))
    }
    
    @objc private func confirmButtonTapped() {
        router.routeToMain()
    }
}

// MARK: - PathDisplayLogic
extension PathViewController: PathDisplayLogic {
    func displayPopulatedEmojis(_ viewModel: PathModel.PopulateEmojis.ViewModel) {
        emojis = viewModel.emojis
        collectionView.reloadData()
    }
    
    func displaySelectedEmoji(_ viewModel: PathModel.SelectEmoji.ViewModel) {
        toggleEmojiSelection(at: viewModel.index)
    }
    
    private func toggleEmojiSelection(at indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PathCell
        cell.emojiView.isSelected.toggle()
    }
}

// MARK: - UICollectionViewDataSource
extension PathViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emojis.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let emoji = emojis[indexPath.item]
        let reuseID = String(describing: PathCell.self)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseID, for: indexPath) as! PathCell
        cell.emojiView.label.text = emoji.emoji
        cell.professionlabel.text = emoji.profession
        if interactor.selectedIndex == indexPath {
            cell.emojiView.isSelected.toggle()
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension PathViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        interactor.selectEmoji(.init(index: indexPath))
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension PathViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Constants.cellSize
    }
}

// MARK: - Setup views
private extension PathViewController {
    func setupViews() {
        addSubviews()
        setupFrames()
        view.backgroundColor = .white
    }
    
    func addSubviews() {
        view.addSubview(collectionView)
        view.addSubview(confirmButton)
    }
    
    func setupFrames() {
        collectionView.frame = CGRect(
            x: Constants.sideOffset,
            y: Constants.screenHeight * 0.1,
            width: Constants.screenWidth - (Constants.sideOffset * 2),
            height: Constants.collectionViewHeight
        )
        confirmButton.frame = CGRect(
            x: (Constants.screenWidth - Constants.buttonWidth) / 2,
            y: collectionView.frame.origin.y + Constants.collectionViewHeight + 50,
            width: Constants.buttonWidth,
            height: Constants.buttonHeight
        )
    }
}


