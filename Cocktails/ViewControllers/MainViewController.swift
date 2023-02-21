//
//  ViewController.swift
//  Cocktails
//
//  Created by Елена Логинова on 21.02.2023.
//

import UIKit

class MainViewController: UIViewController {

    private let link = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=margarita"

    @IBAction func pressStartButton() {
        fetchCocktail()
    }
    
    
    private func fetchCocktail() {
        guard let url = URL(string: link) else { return }
        
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data else {
                self?.showAlert(
                    title: "Error",
                    message: error?.localizedDescription ?? "No error description")
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let cocktail = try jsonDecoder.decode(Cocktail.self, from: data)
                print(cocktail)
                self?.showAlert(title: "Success",
                               message: "You can see the results in the Debug aria")
            } catch {
                self?.showAlert(title: "Failed",
                               message: error.localizedDescription)
            }
        }.resume()
    }
    
    
    private func showAlert(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title,
                                          message: message,
                                          preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
}

