//
//  HomeViewPresentor.swift
//  DinDinnPOC
//
//  Created by Pankaj Talreja on 31/03/21.
//

import Foundation
import Combine
import SwiftUI

class HomeViewPresentor: HomeViewToPresentor {
    
    var cartPresenterToRouter: CartPresenterToRouter!
    weak var viewModel: HomeScreenViewModel!
    var presentorToHomeView: PresentorToHomeView!
    var presentorToInteractor: PresentorToInteractor!


    func navigateToCart() -> AnyView {
        return cartPresenterToRouter.navigateToCartView()
    }
    

    func viewDidLoad() {
        presentorToInteractor.fetchMenuItems()
    }
}


extension HomeViewPresentor: InteractorToPresentor {
    
    ///Update View Model  to show the items on the view
    func itemResult(_ item: Items) {
        print(item)
        self.viewModel.items = item.types
        if let selectedName = item.types.first?.categoryName {
            self.viewModel.selectedCategory = selectedName
        }
    }
    
    ///update the view model to show the error on the screen
    func error(_ error: Error) {
        viewModel.error = true
    }
    
}

