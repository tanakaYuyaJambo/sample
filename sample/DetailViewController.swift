//
//  detailViewController.swift
//  sample
//
//  Created by 田中雄也 on 2022/10/05.
//

import UIKit

final class DetailViewController: UIViewController {
    
    @IBOutlet private weak var numberLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!

    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberLabel.text = "No." + pokemon.pokeId
        nameLabel.text = pokemon.pokeName
        imageView.sd_setImage(with: URL(string: pokemon.pokeImageURL))
    }
}
