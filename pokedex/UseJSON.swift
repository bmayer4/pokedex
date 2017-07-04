//
//  UseJSON.swift
//  pokedex
//
//  Created by Brett Mayer on 7/4/17.
//  Copyright © 2017 Devslopes. All rights reserved.
//

import Foundation
import UIKit

class UseJson {
    
    func readJson() {
        do {
            if let file = Bundle.main.url(forResource: "url", withExtension: "url") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                
                if let object = json as? [[String: Any]] {
                    print(object)
                    for obj in object {
                        if let name = obj["identifier"] as? String {
                            print(name)  //YESSS
                            if let id = obj["id"] as? Int {
                                print(id)
                            }
                        }
                    }
                }
            }
        } catch let err {
            print("Error: \(err)")
        }
    }
    
    
    
    
}
