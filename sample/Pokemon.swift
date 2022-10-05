//
//  Pokemon.swift
//  sample
//
//  Created by takemura on 2022/10/05.
//

import Foundation

struct Pokemon {
    var pokeId:Int
    var pokeName:String
    var pokeImageURL:String
}

struct PokemonData: Codable {
    let id: Int
    let name: String
    let sprites: Sprites
}

struct Sprites: Codable {
    let frontImage: String

    enum CodingKeys: String, CodingKey {
        case front_default = "front_default"
    }
}
