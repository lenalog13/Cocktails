//
//  NavigationController.swift
//  Cocktails
//
//  Created by Елена Логинова on 22.02.2023.
//

import UIKit

class NavigationController: UINavigationController {
    
    var cocktailsList: Cocktail!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    private func fetchCocktail() {
        NetworkManager.shared.fetchCocktail(from: link) { [weak self] result in
            switch result{
            case .success(let cockrails):
                self?.cocktailsList = cockrails
                self?.tableView.reloadData()
            case .failure(let error):
                switch error {
                case .invalidUrl:
                    self?.showAlert(title: "Error", message: "Invalid URL")
                case .noData:
                    self?.showAlert(title: "Error", message: "No Data")
                case .decodingError:
                    self?.showAlert(title: "Error", message: "Decoding Error")
                }
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
