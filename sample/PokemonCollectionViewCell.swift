//
//  CustomCell.swift
//  sample
//
//  Created by 田中雄也 on 2022/10/03.
//

import UIKit
import SDWebImage

final class PokemonCollectionViewCell: UICollectionViewCell {

    static let identifier = "PokemonCollectionViewCell"
    static func nib() -> UINib {
        UINib(nibName: identifier, bundle: nil)
    }

    @IBOutlet private weak var colorArea: UIImageView!
    @IBOutlet private weak var numberLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        let screen_width = UIScreen.main.bounds.size.width
        let screen_height = UIScreen.main.bounds.size.height
        colorArea.layer.frame.size = CGSize(width: screen_width/2.2, height: screen_width/4.4)
        numberLabel.font = UIFont.systemFont(ofSize: 20)
        numberLabel.textAlignment = NSTextAlignment.center
        nameLabel.font = UIFont.systemFont(ofSize: 20)
        nameLabel.textAlignment = NSTextAlignment.center
        imageView.frame.size.width = 100
        imageView.frame.size.height = 100
    }

    func configure(pokemon: Pokemon) {
        numberLabel.text = "No." + pokemon.pokeId
        nameLabel.text = pokemon.pokeName
        imageView.sd_setImage(with: URL(string: pokemon.pokeImageURL))
    }
}
