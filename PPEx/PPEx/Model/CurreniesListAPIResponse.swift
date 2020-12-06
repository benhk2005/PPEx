//
//  CurreniesListAPIResponse.swift
//  PPEx
//
//  Created by Ben Leung on 6/12/2020.
//

import Foundation
import ObjectMapper

class CurrenciesListAPIResponse: Mappable {
    
    var success:Bool?
    var currencies: [String: String]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success     <- map["success"]
        currencies  <- map["currencies"]
    }
    
}
