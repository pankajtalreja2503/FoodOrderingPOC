//
//  WebServices.swift
//  Stocks
//
//  Created by Pankaj Talreja on 19/03/21.
//

import Foundation

protocol APIRequest {
    associatedtype RequestDataType
    associatedtype ResponseDataType
    
    ///Generic method to create the URL Request
    func makeRequest(withData data: RequestDataType) throws -> URLRequest
    
    ///Generic Method to Parse the Data
    func parseData(fromData data: Data) throws -> ResponseDataType
}

class APILoader<T: APIRequest> {
    let apiRequest: T
    let urlSession: URLSession
    typealias completionHandler = (Result<T.ResponseDataType, Error> ) -> ()
    
    init(apiRequest: T, urlSession: URLSession = .shared) {
        self.apiRequest = apiRequest
        self.urlSession = urlSession
    }
    
    ///actual fucntion which will connect with the network
    func loadRequest(fromRequest: T.RequestDataType, completionHandler: @escaping(completionHandler)) {
        
        do {
            let request = try apiRequest.makeRequest(withData: fromRequest)
            urlSession.dataTask(with: request) { (data, urlResponse, error) in
                guard error == nil,
                      let responseData = data,
                      let httpResponse = urlResponse as? HTTPURLResponse,
                      200 ..< 300 ~= httpResponse.statusCode else {
                    completionHandler(.failure(NetworkErrors.invalidRequest))
                    return
                }
                do {
                    let parseValue = try self.apiRequest.parseData(fromData: responseData)
                    completionHandler(.success(parseValue))
                } catch {
                    completionHandler(.failure(error))
                }
            }.resume()
        } catch {
            completionHandler(.failure(error))
        }
        
        
    }
    
}
