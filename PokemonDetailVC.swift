//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Jared Rentz on 12/17/15.
//  Copyright © 2015 UXOThings LLC. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!

    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        name.text = pokemon.name
        img.image = UIImage(named: "\(pokemon.pokedexId)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  
    

}
