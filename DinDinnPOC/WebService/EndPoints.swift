//
//  EndPoints.swift
//  DinDinnPOC
//
//  Created by Pankaj Talreja on 04/04/21.
//

//https://foodorderapp.glitch.me/order-list

import Foundation
struct API {
    static let baseURL = "https://foodorderapp.glitch.me/"
}
protocol EndPoint {
    var path: String {get}
    var url: String {get}
}

///this enum responsible for creation of urls
enum EndPoints {
    enum MenuList: EndPoint {
        case fetch
        var path: String {
            switch self {
            case .fetch:
                return "order-list/"
            }
        }
        
        var url: String {
            switch self {
            case .fetch: return "\(API.baseURL)\(path)"
            }
        }
        
    }
}
