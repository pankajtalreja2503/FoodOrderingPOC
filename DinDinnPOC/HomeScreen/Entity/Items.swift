//
//  Items.swift
//  DinDinnPOC
//
//  Created by Pankaj Talreja on 01/04/21.
//

import Foundation

///Created model & confirm to codable protocol to parse the data which is coming from server
struct Items: Codable {
    var types: [Categories]
}

struct Categories: Codable {
    var categoryName: String = ""
    var categoryItem: [CategoryItems]
}

struct CategoryItems: Codable {
    var title: String = "test"
    var price: Double = 0.0
    var ingredients: String = ""
    var sizeAndWight: String = ""
    var imageURL: String = ""


}
