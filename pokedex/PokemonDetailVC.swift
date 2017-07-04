//
//  PokemonDetailVC.swift
//  pokedex
//
//  Created by Brett Mayer on 7/4/17.
//  Copyright © 2017 Devslopes. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    var poke: Pokemon!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLbl.text = poke.name

    }

    

}
