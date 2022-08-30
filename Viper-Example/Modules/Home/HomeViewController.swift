//
//  HomeViewController.swift
//  Viper-Example
//
//  Created by Mehmet Ateş on 29.08.2022.
//

import UIKit

protocol HomeViewInterface: AnyObject {
    func setupView()
    func setTitle(with title: String)
}

class HomeViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    private var listConfig = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
    var presenter: HomePresenterInterface?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.notifyViewDidLoad()
    }
}

// MARK: - Interface Setup
extension HomeViewController: HomeViewInterface, UICollectionViewDelegate {
    
    func setupView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.setCollectionViewLayout(createLayout(), animated: true)
    }
    
    func setTitle(with title: String) {
        self.title = title
    }
}

// MARK: - Layout Configure
extension HomeViewController {
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { index, environment in
            var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
            configuration.backgroundColor = .secondarySystemBackground
            configuration.headerMode = .none
            return .list(using: configuration, layoutEnvironment: environment)
        }
        return layout
    }
}

// MARK: - CollectionView DataSource
extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.getItemCount ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        presenter?.getSectionCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "baseCell", for: indexPath) as? BaseCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
}
