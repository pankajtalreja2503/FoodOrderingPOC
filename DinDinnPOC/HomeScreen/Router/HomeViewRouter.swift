//
//  HomeViewRouter.swift
//  DinDinnPOC
//
//  Created by Pankaj Talreja on 31/03/21.
//

import SwiftUI

class HomeViewRouter: CartPresenterToRouter {
    
    ///Navigatation to the Cart View
    func navigateToCartView() -> AnyView {
        return AnyView(CartRouter.assumblyModule())
    }
    

}
