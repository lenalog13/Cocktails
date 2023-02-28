//
//  DetailViewController.swift
//  Cocktails
//
//  Created by Елена Логинова on 22.02.2023.
//

import UIKit

final class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var ingridientLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    var cocktail: Cocktail!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = cocktail.strDrink
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchImage()
        ingridientLabel.text = cocktail.ingridients
    }
    
    private func fetchImage() {
        NetworkManager.shared.fetchImage(from: cocktail.strDrinkThumb) {
            [weak self] result in
            switch result {
            case .success(let imageData):
                self?.imageView.image = UIImage(data: imageData)
            case .failure(_):
                self?.imageView.image = UIImage(named: "Cocktail")
            }
            self?.activityIndicator.stopAnimating()
        }
    }
   
}
