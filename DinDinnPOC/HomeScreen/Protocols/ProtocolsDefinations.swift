//
//  ProtocolsDefinations.swift
//  DinDinnPOC
//
//  Created by Pankaj Talreja on 04/04/21.
//

import SwiftUI

protocol HomeViewToPresentor: AnyObject {
    ///Initial function getting called to fetch the data from server
    func viewDidLoad()
    ///This function will be responsible for Navigation to Cart view
    func navigateToCart() -> AnyView
    

    var presentorToHomeView: PresentorToHomeView! {get set}
}


protocol CartViewRouterToPresentor: AnyObject  {
    var cartPresenterToRouter: CartPresenterToRouter! {get set}
}

protocol CartPresenterToRouter: AnyObject  {
    
    ///Call the router function to navigate it to Cart view
    func navigateToCartView() -> AnyView
}

protocol PresentorToHomeView  {
    var homeViewToPresentor: HomeViewToPresentor! {get set}
    
}

protocol PresentorToInteractor: AnyObject  {
    var interactorToPresentor: InteractorToPresentor! {get set}
    
    ///To fetch the menu items
    func fetchMenuItems()
    
}

protocol InteractorToPresentor: AnyObject  {
    var presentorToInteractor: PresentorToInteractor! {get set}
    
    ///This is to notify the presentor for successful connection
    func itemResult(_ item: Items)
    
    ///This is to notify there is an error while connecting to network
    func error(_ error: Error)
}
