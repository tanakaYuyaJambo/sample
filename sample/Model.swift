//
//  Model.swift
//  sample
//
//  Created by takemura on 2022/10/05.
//

import Foundation

final class Model {
    
    private let pokeapi = "https://pokeapi.co/api/v2/pokemon/"
    private var pokemons: [Pokemon] = []

    func fetch(completion: @escaping ([Pokemon]>) -> Void) {

        for i in 1...152 {
            let url : URL = URL(string: pokeapi + String(i))!
            let task: URLSessionTask = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                do{
                    let pokemonData = try JSONDecoder().decode(PokemonData.self, from: data!)
                    var pokemon = Pokemon(pokeId: pokemonData.id, pokeName: pokemonData.name, pokeImageURL: pokemonData.sprites.frontImage)
                    self.pokemons.append(pokemon)
                }
                catch{
                    print(error)
                }
            })
            task.resume()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.pokemons.sort(by: {$0.pokeId < $1.pokeId})
            completion(self.pokemons)
        }
    }
}
