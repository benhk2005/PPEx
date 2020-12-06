//
//  APIHelperInterface.swift
//  PPEx
//
//  Created by Ben Leung on 5/12/2020.
//

import Foundation


protocol APIHelperInterface {
    
    func fetchCurrenciesList(completion: @escaping (Result<[String], APIError>) -> Void)
    
    func fetchExchangeRate(completion: @escaping (Result<[String:Float], APIError>) -> Void)
    
}

