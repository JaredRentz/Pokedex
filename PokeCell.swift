//
//  PokemonTestCell.swift
//  Pokedex
//
//  Created by Jared Rentz on 12/16/15.
//  Copyright © 2015 UXOThings LLC. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon = Pokemon!()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 6.5
        clipsToBounds = true
    }
    

    func configureCell (pokemoninfo:Pokemon) {
        
        nameLbl.text = pokemoninfo.name.capitalizedString
        thumbImg.image = UIImage(named: "\(pokemoninfo.pokedexId)")
        
    }
}
