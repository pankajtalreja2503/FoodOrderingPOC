//
//  HomeScreenViewModel.swift
//  DinDinnPOC
//
//  Created by Pankaj Talreja on 05/04/21.
//

import Combine
import SwiftUI

final class HomeScreenViewModel: ObservableObject {
 
    let objectWillChange = ObservableObjectPublisher()
   
    ///To show the error message if there is network issue
    @Published var error: Bool = false {
        willSet {
            self.objectWillChange.send()
            loading = false

        }
    }

    ///Fetch details from server
    @Published var items: [Categories] = [] {
       willSet {
            self.objectWillChange.send()
            loading = false
        }
    }
    
    ///To keep the track of Loading Indicator
    @Published var loading: Bool = true {
        willSet {
             self.objectWillChange.send()
         }
    }
    
    ///To keep the track of selected Category
    @Published var selectedCategory: String = "" {
       willSet {
            self.objectWillChange.send()
        }
    }
    
    ///To keep the track of selected Category
    @Published var imageData: [String] =  ["Monday", "Thursday", "Friday", "Monday", "Thursday","Monday", "Friday"] {
       willSet {
            self.objectWillChange.send()
        }
    }
}
