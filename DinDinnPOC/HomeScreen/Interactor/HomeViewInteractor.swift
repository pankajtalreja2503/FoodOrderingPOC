//
//  HomeViewInteractor.swift
//  DinDinnPOC
//
//  Created by Pankaj Talreja on 31/03/21.
//

import Foundation

class HomeViewInteractor: PresentorToInteractor {
        var interactorToPresentor: InteractorToPresentor!
    
    ///Fetch the Menu items after connecting to the Server
        func fetchMenuItems() {
            NetworkInterface.fetchOrderItems { (result) in
                
                switch result {
                case .success(let itemsArray) :
                    DispatchQueue.main.async {
                        if itemsArray.count > 0 {
                            self.interactorToPresentor.itemResult(itemsArray.first!)
                        }
                    }
                case .failure(let error):
                    print(error)
                    self.interactorToPresentor.error(error)
                }
                
            }
        }
}
