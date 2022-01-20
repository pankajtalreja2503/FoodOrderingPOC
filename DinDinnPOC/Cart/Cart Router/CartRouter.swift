//
//  CartRouter.swift
//  DinDinnPOC
//
//  Created by Pankaj Talreja on 06/04/21.
//

import SwiftUI


class CartRouter {
    
    ///assubly point where we initialize all the neccessary methods for cart view
    static func assumblyModule() -> some View {
        let cartViewModel = CartViewModel()
        
        var cartView = CartView(viewModel: cartViewModel)
        let presentor = CartViewPresentor()
        var interactor: CartPresentorToInteractor = CartViewInteractor()
        interactor.cartInteractorToPresentor = presentor
        presentor.viewModel = cartViewModel
        presentor.cartPresentorToInteractor = interactor
        presentor.presentorToCartView = cartView
        cartView.cartViewToPresentor = presentor
        cartView.viewModel = cartViewModel
        return cartView
    }
    
    
}
