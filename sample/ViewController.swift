//
//  ViewController.swift
//  sample
//
//  Created by 田中雄也 on 2022/10/02.
//

import UIKit
import SDWebImage

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    let screen_width = UIScreen.main.bounds.size.width
    
    struct Pokemons{
        var pokeId:Int
        var pokeName:String
        var pokeImageURL:String
    }
     
    let pokeapi = "https://pokeapi.co/api/v2/pokemon/"
    
    struct PokemonData: Codable{
        let id: Int
        let name: String
        let sprites: Sprites
    }
    
    struct Sprites: Codable {
        let front_default: String
        
        enum CodingKeys: String, CodingKey {
            case front_default = "front_default"
        }
    }
    
    var pokemons: [Pokemons] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CustomCell", bundle: nil), forCellWithReuseIdentifier: "Cell")

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: screen_width/2.2, height: screen_width/2.2)
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionView.collectionViewLayout = layout
        self.navigationItem.title = "一覧"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBarAppearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        for i in 1...152{
            let url : URL = URL(string: pokeapi + String(i))!
            let task: URLSessionTask = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
                do{
                    let pokemonData = try JSONDecoder().decode(PokemonData.self, from: data!)
                    var pokemon = Pokemons(pokeId: pokemonData.id, pokeName: pokemonData.name, pokeImageURL: pokemonData.sprites.front_default)
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
            self.collectionView.reloadData()
        }
        
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemons.count - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CustomCell else {
            fatalError("Wrong cell class dequeued")
        }
        cell.layer.cornerRadius = screen_width/4.4
        cell.layer.borderWidth = 1
        cell.numberLabel.text = "No." + String(indexPath.item + 1)
        cell.nameLabel.text = pokemons[indexPath.item].pokeName
        cell.imageView.sd_setImage(with: URL(string: pokemons[indexPath.item].pokeImageURL))
        
        let cell_width = cell.bounds.size.width
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "detailViewController")as! detailViewController
        detailVC.number = String(indexPath.item + 1)
        detailVC.name = pokemons[indexPath.item].pokeName
        detailVC.imageURL = pokemons[indexPath.item].pokeImageURL
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

