//
//  TableviewRouter.swift
//  DinDinnPOC
//
//  Created by Pankaj Talreja on 04/04/21.
//

import Foundation
import SwiftUI
import Combine
class TableviewRouter {
    
    ///Call to configure Table view
    static func assumblyModule(items: Binding<[Categories]>, selectedCategory: Binding<String>, tapOnSection: Binding<Bool>, onDragStarted: @escaping (DragGesture.Value) -> (), onDragEnd: @escaping (DragGesture.Value) -> (), g: GeometryProxy) -> some View {
        
        let homeTableViewModel = HomeScreenTableViewModel()
        var homeTableView = HomeTableView(items: items, selectedCategory: selectedCategory, tapOnSection: tapOnSection, onDragStarted: onDragStarted, onDragEnd: onDragEnd, g: g, viewModel: homeTableViewModel)
        let presentor = HomeTableViewPresentor()
        homeTableView.homeTableViewToPresentor = presentor
        presentor.viewModel = homeTableViewModel
        presentor.presentorToHomeTableView = homeTableView
        return homeTableView
    }
}
