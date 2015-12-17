//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Jared Rentz on 12/17/15.
//  Copyright © 2015 UXOThings LLC. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var baseAttackLbl: UILabel!
    @IBOutlet weak var nextEvoLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    

    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLbl.text = pokemon.name
        mainImg.image = UIImage(named: "\(pokemon.pokedexId)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        
        
    }

  
    

}
