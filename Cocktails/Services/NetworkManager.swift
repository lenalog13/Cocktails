//
//  NetworkManager.swift
//  Cocktails
//
//  Created by Елена Логинова on 22.02.2023.
//

import Foundation
import Alamofire


final class NetworkManager {
    
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
                    completion: @escaping(Result<Data, AFError>) -> Void) {
        
        AF.request(url ?? "")
            .validate()
            .responseData { dataRequest in
                switch dataRequest.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let errore):
                    completion(.failure(errore))
                }
            }
    }
    
}


