//
//  HomeScreenTableViewModel.swift
//  DinDinnPOC
//
//  Created by Pankaj Talreja on 05/04/21.
//


import Combine
import SwiftUI

final class HomeScreenTableViewModel: ObservableObject {
    
    let objectWillChange = ObservableObjectPublisher()
    
    @Published var error: Bool = false {
        willSet {
            self.objectWillChange.send()
        }
    }
    
    ///get the items under the other categories
    @Published var categoryItems: [CategoryItems] = [] {
        willSet {
            self.objectWillChange.send()
        }
    }
    
    @Published var selectedCategory: String = "" {
        willSet {
            self.objectWillChange.send()
        }
    }
//    @Binding var selectedCategory: String
//    @Binding var tapOnSection: Bool
//    @State var buttonTapped: Bool = false
//    @State var selectedProduct = ""
//    var onDragStarted: (DragGesture.Value) -> ()
//    var onDragEnd: (DragGesture.Value) -> ()
//    let screenSize = UIScreen.main.bounds.size
}
