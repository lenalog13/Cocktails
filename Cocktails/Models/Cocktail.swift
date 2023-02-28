//
//  Cocktail.swift
//  Cocktails
//
//  Created by Елена Логинова on 21.02.2023.
//

import Foundation

struct Cocktail: Decodable {
    
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

    init(cocktailData: [String: Any?]) {
    strDrink = cocktailData["strDrink"] as? String ?? ""
    strDrinkThumb = cocktailData["strDrinkThumb"] as? String
    strIngredient1 = cocktailData["strIngredient1"] as? String ?? ""
    strIngredient2 = cocktailData["strIngredient2"] as? String
    strIngredient3 = cocktailData["strIngredient3"] as? String
    strIngredient4 = cocktailData["strIngredient4"] as? String
    strIngredient5 = cocktailData["strIngredient5"] as? String
    strIngredient6 = cocktailData["strIngredient6"] as? String
    strIngredient7 = cocktailData["strIngredient7"] as? String
    }
    
    static func getCocktails(from value: Any) -> [Cocktail] {
        var cocktails: [Cocktail] = []
        
        guard
            let cocktailsData = value as? [String: [Any]] else {
            return cocktails
        }
        
        guard
            let drinksData = cocktailsData["drinks"] as? [[String: Any]] else {
            return cocktails
        }
        
        for cocktailData in drinksData {
            let cocktail = Cocktail(cocktailData: cocktailData)
            cocktails.append(cocktail)
        }
        
        return cocktails
    }
}



