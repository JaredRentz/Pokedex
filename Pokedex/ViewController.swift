//
//  ViewController.swift
//  Pokedex
//
//  Created by Jared Rentz on 12/16/15.
//  Copyright © 2015 UXOThings LLC. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var CollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var musicPlayer = AVAudioPlayer()
    var pokemon = [Pokemon]()
    var inSearchMode = false
    var filteredSearch = [Pokemon]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parsePokemonCSV()
        initalizeMusic()
        searchBar.returnKeyType = UIReturnKeyType.Done
    }
    
    // Mark - Automatically play audio
    
    func initalizeMusic () {
        let path = NSBundle.mainBundle().pathForResource("music", ofType: "mp3")
        
        do {
            musicPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: path!)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    
    // Mark - Parse Data
    func parsePokemonCSV() {
        
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        
        do {
        let csv = try CSV(contentsOfURL: path)
        let rows = csv.rows
       
    // now we need a loop to run through the pokemon.csv file and print to the cell label.
            
            for row in rows {
                let pokeId = Int(row ["id"]!)!
                let name = row ["identifier"]!
                let poke = Pokemon(name: name, pokedexId: pokeId)
                
                pokemon.append(poke)
            }
            
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        
    }
   // Mark - Cell Functions
   
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Pokedex", forIndexPath: indexPath) as? PokeCell {
            
            let poke: Pokemon!
            
            if inSearchMode {
                poke = filteredSearch[indexPath.row]
            } else {
                poke = pokemon[indexPath.row]
            }
            cell.configureCell(poke)
            return cell
        } else {
            
            return UICollectionViewCell()
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode {
        return filteredSearch.count
   
        }
    
     return pokemon.count
    
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(118, 118)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    
        let poke: Pokemon!
        
        if inSearchMode {
            poke = filteredSearch[indexPath.row]
        } else {
            poke = pokemon[indexPath.row]
        }
        
        performSegueWithIdentifier("PokemonDetailVC", sender: poke)
        
            }

    @IBAction func onMusicButtonPressed(sender: UIButton) {
        
        if musicPlayer.playing {
            musicPlayer.stop()
            sender.alpha = 0.2
        } else {
            
            musicPlayer.play()
            sender.alpha = 1.0
        }

    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            view.endEditing(true)
            reload()
            
        } else {
            inSearchMode = true
            let lower = searchBar.text!.lowercaseString
            filteredSearch = pokemon.filter({$0.name.rangeOfString(lower) != nil})
            reload()
        }
        
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func reload() {
        CollectionView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier  == "PokemonDetailVC" {
            if let detailsVC = segue.destinationViewController as? PokemonDetailVC {
                if let poke = sender as? Pokemon {
                    detailsVC.pokemon = poke
                }
            }
        }
           }
}

