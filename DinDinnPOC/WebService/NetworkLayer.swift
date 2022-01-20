//
//  NetworkLayer.swift
//  Stocks
//
//  Created by Pankaj Talreja on 19/03/21.
//

import Foundation

class NetworkInterface: NSObject {
    
    ///Creation of network interface for fetching the order
    static func fetchOrderItems(api: String = EndPoints.MenuList.fetch.url, completionHandler: @escaping((Result<[Items], Error>) -> ())) {
        let apiLoader = APILoader(apiRequest: OrderDetailsService())
        apiLoader.loadRequest(fromRequest: api, completionHandler: completionHandler)
    }
    
}


enum NetworkErrors: Error {
    case invalidResponse(Data?, URLResponse?)
    case URLError(Error?)
    case ParsingError(Error?)
    case invalidRequest
}
