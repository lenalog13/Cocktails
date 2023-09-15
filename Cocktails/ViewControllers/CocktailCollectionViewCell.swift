//
//  CocktailCollectionViewCell.swift
//  Cocktails
//
//  Created by Елена Логинова on 12.09.2023.
//

import UIKit

final class CocktailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var cocktailImageView: UIImageView!
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    func configure(with cocktail: Cocktail) {
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchImage(with: cocktail.strDrinkThumb ?? "")
        activityIndicator.stopAnimating()
        layer.cornerRadius = 10

    }
    
    private func fetchImage(with url: String) {
        NetworkManager.shared.fetchImage(from: url) {
            [weak self]result in
            switch result {
            case .success(let imageData):
                self?.cocktailImageView.image = UIImage(data: imageData)
            case .failure(_):
                self?.cocktailImageView.image = UIImage(named: "Cocktail")
            }
        }
    }
    
}
