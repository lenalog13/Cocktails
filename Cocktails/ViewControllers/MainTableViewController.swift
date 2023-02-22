//
//  ViewController.swift
//  Cocktails
//
//  Created by Елена Логинова on 21.02.2023.
//

import UIKit

class MainTableViewController: UITableViewController {

    var cocktailsList = Cocktail(drinks: [])

    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCocktail()
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        cocktailsList.drinks.count
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "showDetails", for: indexPath)
        let cocktail = cocktailsList.drinks[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = cocktail.strDrink
        cell.contentConfiguration = content
        return cell
    }
    
    
    private func fetchCocktail() {
        NetworkManager.shared.fetchCocktail(from: link) { [weak self] result in
            switch result{
            case .success(let cockrails):
                self?.cocktailsList = cockrails
                self?.tableView.reloadData()
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

