//
//  NetworkManager.swift
//  Cocktails
//
//  Created by Елена Логинова on 22.02.2023.
//

import Foundation

let link = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=margarita"

enum NetworkError: Error {
    case invalidUrl
    case noData
    case decodingError
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    
    func fetchCocktail(from url: String?,
                       completion: @escaping(Result<Cocktail, NetworkError>) -> Void) {
        guard let url = URL(string: url ?? "") else {
            completion(.failure(.invalidUrl))
            return
        }
        
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let cocktail = try jsonDecoder.decode(Cocktail.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(cocktail))
                }
            } catch {
                completion(.failure(.decodingError))
            }
            
        }.resume()
    }
    
    
    func fetchImage(from url: String?,
                    completion: @escaping(Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url ?? "") else {
            completion(.failure(.invalidUrl))
            return
        }
        
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    
}
