//
//  CurrenciesRateAPIResponse.swift
//  PPEx
//
//  Created by Ben Leung on 6/12/2020.
//

import Foundation
import ObjectMapper

class CurrenciesRateAPIResponse: Mappable {
    
    var success:Bool?
    var quotes: [String:Float]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success     <- map["success"]
        quotes      <- map["quotes"]
    }
    
}
