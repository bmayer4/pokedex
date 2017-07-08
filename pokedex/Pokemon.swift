//
//  Pokemon.swift
//  pokedex
//
//  Created by Brett Mayer on 7/1/17.
//  Copyright © 2017 Devslopes. All rights reserved.
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
    private var _nextEvolutionTxt: String!
    private var _nextEvolutionName: String!
    private var _nextEvolutionID: String!
    private var _nextEvolutionLevel: String!
    
    private var _pokemonURL: String!
    
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    var nextEvolutionLevel: String {
        if _nextEvolutionLevel  == nil {
            return ""
        }
        return _nextEvolutionLevel
    }
    
    var nextEvolutionID: String {
        if _nextEvolutionID  == nil {
            return ""
        }
        return _nextEvolutionID
    }
    
    var nextEvolutionName: String {
        if _nextEvolutionName  == nil {
            return ""
        }
        return _nextEvolutionName
    }
    
    var nextEvolutionTxt: String {
        if _nextEvolutionTxt  == nil {
             return ""
        }
        return _nextEvolutionTxt
    }
    
    var attack: String {
        if _attack  == nil {
            return ""
        }
        return _attack
    }
    
    var weight: String {
        if _weight  == nil {
            return ""
        }
        return _weight
    }
    
    var height: String {
        if _height  == nil {
            return ""
        }
        return _height
    }
    
    var defense: String {
        if _defense  == nil {
            return ""
        }
        return _defense
    }
    
    var type: String {
        if _type  == nil {
            return ""
        }
        return _type
    }
    
    var description: String {
        if _description  == nil {
            return ""
        }
        return _description
    }



    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(pokedexId)/"
    }
    
    //network calls are asynchronous
    //let VC know when data will be available, do it w/ a closure
    func downloadPokemonDetail(completed: @escaping DownloadComplete) {
        Alamofire.request(_pokemonURL).responseJSON() { response in  //could do (response) -> Void in
            
            //dict is dictionary of keys with values like string and even other dictionaries
            if let dict = response.result.value as? Dictionary<String, Any> {
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int {
                    self._attack = String(attack)
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = String(defense)
                }
                
                print(self._weight, self._height, self._attack, self._defense)
                
                //types value is array  of dictionaries
                if let types = dict["types"] as? [Dictionary<String, String>] , types.count > 0 {
                    if let name1 = types[0]["name"] as? String {
                        self._type = name1.capitalized
                    }
                    if types.count > 1 {
                        for x in 1..<types.count {
                            if let nameType2 = types[x]["name"] as? String, types.count > 1 {
                                self._type! += "/\(nameType2.capitalized)"
                            }

                        }
                    }
                    
                } else {
                    self._type = ""
                }
                
                if let descArray = dict["descriptions"] as? [Dictionary<String, String>], descArray.count > 0 {
                    if let url = descArray[0]["resource_uri"] as? String {
                        let descURL = "\(URL_BASE)\(url)"
                        
                        Alamofire.request(descURL).responseJSON() { response in
                            if let desDict = response.result.value as? Dictionary<String, Any> {
                                if let des = desDict["description"] as? String {
                                    let fixedDesc = des.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                    self._description = fixedDesc
                                    print(fixedDesc)
                                }
                            }
                            completed() //need THIS! even though there is one completion handler-
                        }
                        
                    }
                } else {
                    self._description = ""
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, Any>], evolutions.count > 0 {
                    if let nextEvo = evolutions[0]["to"] as? String {
                        if nextEvo.range(of: "mega") ==  nil {  //we want to exclude megas
                            self._nextEvolutionName = nextEvo
                            
                            if let uri = evolutions[0]["resource_uri"] as? String {  //easier than making another API call
                                let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextEvoID = newStr.replacingOccurrences(of: "/", with: "")
                                
                                self._nextEvolutionID = nextEvoID
                                
                                if let lvlExist = evolutions[0]["level"] as? Int {
                                    self._nextEvolutionLevel = String(lvlExist)
                                } else {
                                    self._nextEvolutionLevel = ""
                                }
                            }
                        }
                    }
                    print(self._nextEvolutionLevel, self._nextEvolutionName, self._nextEvolutionID)
                }
                
            }
            completed()  //before Alamofire.request ends
        }
    }
    
    
}
