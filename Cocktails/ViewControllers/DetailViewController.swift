//
//  DetailViewController.swift
//  Cocktails
//
//  Created by Елена Логинова on 22.02.2023.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var ingridientLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    var drink: Drink!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = drink.strDrink
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchImage()
        getTextLabel()
    }
    
    private func fetchImage() {
        NetworkManager.shared.fetchImage(from: drink.strDrinkThumb) {
            [weak self] result in
            switch result {
            case .success(let imageData):
                self?.imageView.image = UIImage(data: imageData)
                self?.activityIndicator.stopAnimating()
            case .failure(_):
                self?.imageView.image = UIImage(named: "Cocktail")
                self?.activityIndicator.stopAnimating()
            }
        }
    }
   
    private func getTextLabel() {
        var ingridients = "Ingridients: \(drink.strIngredient1)"
        if let ingridient = drink.strIngredient2 {
            ingridients += ", \(ingridient)"
        }
        if let ingridient = drink.strIngredient3 {
            ingridients += ", \(ingridient)"
        }
        if let ingridient = drink.strIngredient4 {
            ingridients += ", \(ingridient)"
        }
        if let ingridient = drink.strIngredient5 {
            ingridients += ", \(ingridient)"
        }
        if let ingridient = drink.strIngredient6 {
            ingridients += ", \(ingridient)"
        }
        if let ingridient = drink.strIngredient7 {
            ingridients += ", \(ingridient)"
        }
        ingridientLabel.text = ingridients
    }
    

}
