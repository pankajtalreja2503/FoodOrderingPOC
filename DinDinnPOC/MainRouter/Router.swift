//
//  Router.swift
//  DinDinnPOC
//
//  Created by Pankaj Talreja on 31/03/21.
//

import Foundation
import SwiftUI

class Router {
    ///Router created for creation of Home View
    static func assembly() -> some View {
        return HomeScreenRouter.assumblyModule()
    }
}



class HomeScreenRouter {
    ///Router created for creation of Home View
    static func assumblyModule() -> some View {
        let homeViewModel = HomeScreenViewModel()
        
        var homeView = ContentView(viewModel: homeViewModel)
        let presentor = HomeViewPresentor()
        let interactor: PresentorToInteractor = HomeViewInteractor()
        interactor.interactorToPresentor = presentor
        presentor.viewModel = homeViewModel
        presentor.cartPresenterToRouter = HomeViewRouter()
        presentor.presentorToInteractor = interactor
        presentor.presentorToHomeView = homeView
        homeView.homeViewToPresentor = presentor
        homeView.viewModel = homeViewModel
        return homeView
    }
    
    
}
