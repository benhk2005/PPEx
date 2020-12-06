//
//  APIHelper.swift
//  PPEx
//
//  Created by Ben Leung on 5/12/2020.
//

import Foundation
import Alamofire

struct APIError: Error {
    
    private(set) var errorMsg: String
    
}

class APIHelper: APIHelperInterface {
    
    func fetchCurrenciesList(completion: @escaping (Result<[String], APIError>) -> Void) {
        let param = [ "access_key" : Config.API_KEY ]
        AF.request("http://api.currencylayer.com/list", parameters: param).responseJSON { (response) in
            if let error = response.error {
                completion(.failure(APIError(errorMsg: error.localizedDescription)))
                return
            }
            guard let responseMap = response.value as? [String : Any] else {
                completion(.failure(APIError(errorMsg: "Invalid JSON format")))
                return
            }
            guard let responseObj = CurrenciesListAPIResponse(JSON: responseMap), let keys = responseObj.currencies?.keys else {
                completion(.failure(APIError(errorMsg: "Unable to parse JSON")))
                return
            }
            if (!(responseObj.success ?? false) || responseObj.currencies == nil){
                completion(.failure(APIError(errorMsg: "Unable to parse JSON")))
                return
            }
            completion(.success(Array(keys)))
        }
    }
    
    func fetchExchangeRate(completion: @escaping (Result<[String : Float], APIError>) -> Void) {
        let param = [ "access_key" : Config.API_KEY ]
        AF.request("http://api.currencylayer.com/live", parameters: param).responseJSON { (response) in
            if let error = response.error {
                completion(.failure(APIError(errorMsg: error.localizedDescription)))
                return
            }
            guard let responseMap = response.value as? [String : Any] else {
                completion(.failure(APIError(errorMsg: "Invalid JSON format")))
                return
            }
            guard let responseObj = CurrenciesRateAPIResponse(JSON: responseMap), let quotes = responseObj.quotes else {
                completion(.failure(APIError(errorMsg: "Unable to parse JSON")))
                return
            }
            if (!(responseObj.success ?? false)){
                completion(.failure(APIError(errorMsg: "Unable to parse JSON")))
                return
            }
            completion(.success(quotes))
        }
    }
    
}
