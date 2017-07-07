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
    
    @IBOutlet weak var miainIMG: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLbl.text = poke.name

    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    

}
