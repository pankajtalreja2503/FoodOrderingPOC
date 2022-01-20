//
//  HomeTableViewPresentor.swift
//  DinDinnPOC
//
//  Created by Pankaj Talreja on 04/04/21.
//

import Foundation

class HomeTableViewPresentor: HomeTableViewToPresentor {
    weak var viewModel: HomeScreenTableViewModel!
    
    ///Filter Menu items on selection of category
    func filterMenu(onSelection selectedCategory: String, itemsArray: [Categories]) -> [CategoryItems]{
        if let categoryItems = itemsArray.filter({$0.categoryName == selectedCategory}).first?.categoryItem {
            viewModel.categoryItems = categoryItems
            return categoryItems
        } else {
            viewModel.categoryItems = [CategoryItems]()
            return [CategoryItems]()
            
        }
    }
    var presentorToHomeTableView: PresentorToHomeTableView!
    
}
