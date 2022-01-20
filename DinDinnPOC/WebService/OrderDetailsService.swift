//
//  OrderDetailsService.swift
//  DinDinnPOC
//
//  Created by Pankaj Talreja on 04/04/21.
//

import Foundation

class OrderDetailsService: APIRequest {
    
    ///Make URL request for fetching the orders
    func makeRequest(withData urlString: String) throws -> URLRequest {
        guard let url = URL(string: urlString) else {
            throw NetworkErrors.invalidRequest
        }
        return URLRequest(url: url)
    }
    
    ///This method is used for parsing the data
    func parseData(fromData data: Data) throws -> [Items] {
        return try JSONDecoder().decode([Items].self, from: data)
    }
    
}
