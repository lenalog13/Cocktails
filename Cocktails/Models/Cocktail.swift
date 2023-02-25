//
//  Cocktail.swift
//  Cocktails
//
//  Created by Елена Логинова on 21.02.2023.
//

import Foundation

struct Drink: Decodable {
    
    let strDrink: String
    let strDrinkThumb: String?
    
    let strIngredient1: String
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    
    var ingridients: String {
      var line =  """
                    \(strIngredient1), \(strIngredient2 ?? ""), \(strIngredient3 ?? ""), \(strIngredient4 ?? ""), \(strIngredient5 ?? ""), \(strIngredient6 ?? ""), \(strIngredient7 ?? "")
                    """
        
        while line.last == " " || line.last == "," {
            line.removeLast()
        }
        
        return line
    }
}



struct Cocktail: Decodable {
    
    let drinks: [Drink]
    
}


