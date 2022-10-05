//
//  ViewController.swift
//  sample
//
//  Created by 田中雄也 on 2022/10/02.
//

import UIKit

final class ViewController: UIViewController {

    // MARK: - Outlet
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(PokemonCollectionViewCell.nib(), forCellWithReuseIdentifier: PokemonCollectionViewCell.identifier)
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: screenWidth / 2.2, height: screenWidth / 2.2)
            layout.minimumLineSpacing = 10
            layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            collectionView.collectionViewLayout = layout
        }
    }


    // MARK: - Properties
    private let screenWidth = UIScreen.main.bounds.size.width
    private var pokemons: [Pokemon] = []
    private let model = Model()


    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        model.fetch { [weak self] pokemons in
            guard let strongSelf = self else { return }
            strongSelf.pokemons = pokemons
            strongSelf.collectionView.reloadData()
        }
    }


    // MARK: - Methods
    private func setupNavigationBar() {
        navigationItem.title = "一覧"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBarAppearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}


// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemons.count - 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCollectionViewCell.identifier, for: indexPath) as! PokemonCollectionViewCell 
        cell.layer.cornerRadius = screenWidth / 4.4
        cell.layer.borderWidth = 1
        cell.configure(pokemon: pokemons[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVC.pokemon = pokemons[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

