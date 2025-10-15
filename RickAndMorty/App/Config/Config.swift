//
//  Config.swift
//  RickAndMorty
//
//  Created by Pedro Juan Baeza Gómez on 15/10/25.
//

import Foundation

struct Config {
    
    static var baseURL: URL? {
        
        guard let dictionary = Bundle.main.infoDictionary else {
            return nil
        }
        
        guard let baseUrlString = dictionary["BASE_URL"] as? String else {
            return nil
        }
        
        return URL(string: baseUrlString)
    }
}
