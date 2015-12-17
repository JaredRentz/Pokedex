//
//  ViewController.swift
//  Pokedex
//
//  Created by Jared Rentz on 12/16/15.
//  Copyright © 2015 UXOThings LLC. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var CollectionView: UICollectionView!
    
    var musicPlayer = AVAudioPlayer()
    var pokemon = [Pokemon]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parsePokemonCSV()
        initalizeMusic()
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
    
   
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Pokedex", forIndexPath: indexPath) as? PokeCell {
            
            let poke = pokemon[indexPath.row]
            cell.configureCell(poke)
            return cell
            
        } else {
            
            return PokeCell()
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemon.count
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(118, 118)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    
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
    
}

