//
//  CartViewPresentor.swift
//  DinDinnPOC
//
//  Created by Pankaj Talreja on 05/04/21.
//

import Foundation
import Combine
import SwiftUI

class CartViewPresentor: CartViewToPresentor {
    var presentorToCartView: PresentorToCartView!
    var cartPresentorToInteractor: CartPresentorToInteractor!
    var viewModel: CartViewModel!
 
    ///initial call to fetch the details from coredata
    func viewDidLoad() {
        cartPresentorToInteractor.fetchCartItems()
        
    }
    
    ///delete the order on click of cross
    func deleteOrder(name: String) {
        cartPresentorToInteractor.deleteOrder(name: name)
    }
    
    func deleteAllData() {
        cartPresentorToInteractor.deleteAllData()
    }
}


extension CartViewPresentor: CartInteractorToPresentor {
    
    ///It will respond to presentor after retreiving the values from cart
    func cartResult(_ cartitem: Modelcart) {
        viewModel.cart = cartitem
    }
    
}
