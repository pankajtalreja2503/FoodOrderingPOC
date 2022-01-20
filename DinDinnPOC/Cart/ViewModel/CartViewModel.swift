//
//  CartViewModel.swift
//  DinDinnPOC
//
//  Created by Pankaj Talreja on 05/04/21.
//


import Combine
import SwiftUI

final class CartViewModel: ObservableObject {
    
    let objectWillChange = ObservableObjectPublisher()
    
    @Published var error: Bool = false {
        willSet {
            self.objectWillChange.send()
        }
    }
    
    /// to get the model details for cart view
    @Published var cart: Modelcart = Modelcart() {
        willSet {
            self.objectWillChange.send()
        }
    }
    
}
