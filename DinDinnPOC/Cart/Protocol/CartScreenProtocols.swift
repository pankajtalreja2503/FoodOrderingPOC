//
//  CartScreenProtocols.swift
//  DinDinnPOC
//
//  Created by Pankaj Talreja on 05/04/21.
//

import Foundation


protocol CartViewToPresentor {
    ///initial call to fetch the details from coredata
    func viewDidLoad()
    
    ///delete the order on click of cross
    func deleteOrder(name: String)
    
    //delete all the orders
    func deleteAllData()
    
    var presentorToCartView: PresentorToCartView! {get set}
}


protocol PresentorToCartView {
    var cartViewToPresentor: CartViewToPresentor! {get set}
    
}

protocol CartPresentorToInteractor {
    ///Call the interactor for fetching the order details
    var cartInteractorToPresentor: CartInteractorToPresentor! {get set}
    ///Delete the order from coredata
    func deleteOrder(name: String)
    
    //Delete all the orders from CoreData
    func deleteAllData()
    
    ///fetch Cart Items from database
    func fetchCartItems()
    
}

protocol CartInteractorToPresentor {
    var cartPresentorToInteractor: CartPresentorToInteractor! {get set}
    
    ///It will respond to presentor after retreiving the values from cart
    func cartResult(_ cartitem: Modelcart)
}

