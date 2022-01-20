//
//  CartViewInteractor.swift
//  DinDinnPOC
//
//  Created by Pankaj Talreja on 05/04/21.
//

import Foundation

class CartViewInteractor: CartPresentorToInteractor {
    //        var interactorToPresentor: InteractorToPresentor!
    var cartInteractorToPresentor: CartInteractorToPresentor!
    
    ///Call the interactor for fetching the order details
    func fetchCartItems() {
        let valueAfterCalculation = calculateTotal(order: CoreDataManager.shared.getAllOrders())
        cartInteractorToPresentor.cartResult(valueAfterCalculation)
    }
    
    ///Delete the order from coredata
    func deleteOrder(name: String) {
        CoreDataManager.shared.deleteOrder(name: name)
        let valueAfterCalculation = calculateTotal(order: CoreDataManager.shared.getAllOrders())
        cartInteractorToPresentor.cartResult(valueAfterCalculation)
    }
    
    func deleteAllData() {
        CoreDataManager.shared.deleteAllData()
        let valueAfterCalculation = calculateTotal(order: CoreDataManager.shared.getAllOrders())
        cartInteractorToPresentor.cartResult(valueAfterCalculation)
    }
    
    ///Calculate the total price
    func calculateTotal(order: [Order]) -> Modelcart {
        
        let total = order.compactMap { $0.price }.reduce(0, +)
        return Modelcart(total: total, cartItems: order.map(CartItems.init))
    }
    
}
