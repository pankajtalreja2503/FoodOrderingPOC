//
//  CartModel.swift
//  DinDinnPOC
//
//  Created by Pankaj Talreja on 03/04/21.
//

import Foundation

struct CartModel {
    let name: String
    let categoryName: String
    let price: Double
    let quantity: Int16
    let imageURL: String
    func saveOrder() {
        if let order = CoreDataManager.shared.fetchOrder(withName: name) {
            if order.name == name {
                order.quantity += 1
                order.price = price * Double(order.quantity)
                CoreDataManager.shared.save()
            }
        } else {
            CoreDataManager.shared.saveOrde(categoryName: categoryName, price: price, quantity: Int(quantity), name: name, imageURL: imageURL)
            
        }
    }
    
    
}


///Model created for Cart view
struct Modelcart {
    var total: Double = 0.0
    var cartItems = [CartItems]()
}

///Model created for cart view for each items in the order
struct CartItems {
    let name: String
    let categoryName: String
    let price: Double
    let quantity: Int16
    let totalPrice: Double = 0.0
    let imageURL: String
    init(order: Order) {
        self.name = order.name ?? "default"
        self.categoryName = order.categoryName ?? "Default"
        self.price = order.price
        self.quantity = order.quantity
        self.imageURL = order.imageURL ?? ""
    }
}
