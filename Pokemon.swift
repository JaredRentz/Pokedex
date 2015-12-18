//
//  Pokemon.swift
//  Pokedex
//
//  Created by Jared Rentz on 12/16/15.
//  Copyright © 2015 UXOThings LLC. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolution: String!
    private var _pokemonUrl: String!
    
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    init(name:String, pokedexId: Int) {
       self._name = name
        self._pokedexId = pokedexId
    
   
        _pokemonUrl = "\(URL_BASE)\(URL_Pokemon)\(_pokedexId)"
        
    }
    
    func downloadPokemon(downloaded: downloadComplete ) {
        let url = _pokemonUrl
        Alamofire.request(.GET, url).responseJSON {response in let result = response.result
            
            // print(result.value.debugDescription) 
            // Next convert JSON data into IOS Dictionary
            
            if let dict = result.value as? Dictionary < String, AnyObject> {
                
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                
                if let types = dict["types"] as? [Dictionary <String, String>] where types.count > 0 {
                    
                    if let name = types[0]["name"] {
                        self._type = name
                        
                    }
                    
                    if types.count > 1 {
                        
                        for var x = 1; x < types.count; x++ {
                            if let name = types[x]["name"] {
                            self._type! += "/\(name)"
                        }
                    }
                
                
                    }
                }
            }
        
        }
        }
}