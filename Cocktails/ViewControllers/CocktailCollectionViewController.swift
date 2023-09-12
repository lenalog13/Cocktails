//
//  MainCollectionViewController.swift
//  Cocktails
//
//  Created by Елена Логинова on 11.09.2023.
//

import UIKit

final class CocktailCollectionViewController: UICollectionViewController {
    
    
    private let link = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=margarita"
    private var cocktailsList: [Cocktail] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCocktail()
    }

  
    // MARK: - Navigation

    
        /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = collectionView.indexPathsForSelectedItems {
            guard
                let detailVS = segue.destination as? DetailViewController else { return }
            detailVS.cocktail = cocktailsList[indexPath.item]
        }
    }
         */
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cocktailsList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cocktail", for: indexPath) as! CocktailCollectionViewCell
    
        cell.backgroundColor = .black
    
        return cell
    }

    
    private func fetchCocktail() {
        NetworkManager.shared.fetchCocktail(from: link) { [weak self] result in
            switch result{
            case .success(let cocktails):
                self?.cocktailsList = cocktails
                self?.collectionView.reloadData()
            case .failure(let error):
                self?.showAlert(title: "Error", message: error.localizedDescription)
            }
        }
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


extension CocktailCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemPerRow: CGFloat = 2
        let peddingWidth = 16 * (itemPerRow + 1)
        let availableWifth = collectionView.frame.width - peddingWidth
        let widthPerItem = availableWifth / itemPerRow
        return CGSize(width: widthPerItem, height: 1.5 * widthPerItem)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top:  16, left: 16, bottom: 16, right: 16)
    }
    
    
}
