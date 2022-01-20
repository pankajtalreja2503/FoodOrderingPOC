//
//  HomeTableViewProtocol.swift
//  DinDinnPOC
//
//  Created by Pankaj Talreja on 04/04/21.
//

import Foundation

protocol HomeTableViewToPresentor {
    
    ///Filter Menu items on selction of category
    func filterMenu(onSelection selectedCategory: String, itemsArray:[Categories]) -> [CategoryItems]
    var presentorToHomeTableView: PresentorToHomeTableView! {get set}
}


protocol PresentorToHomeTableView {
    var homeTableViewToPresentor: HomeTableViewToPresentor! {get set}
    
}
