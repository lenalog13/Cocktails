//
//  NetworkManager.swift
//  Cocktails
//
//  Created by Елена Логинова on 22.02.2023.
//

import Foundation
import Alamofire


enum NetworkError: Error {
    case invalidUrl
    case noData
    case decodingError
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    
    func fetchCocktail(from url: String?,
                       completion: @escaping(Result<[Cocktail], AFError>) -> Void) {
        
        AF.request(url ?? "")
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let cocktails = Cocktail.getCocktails(from: value)
                    completion(.success(cocktails))
                case .failure(let error):
                    completion(.failure(error))
                }
        }
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


