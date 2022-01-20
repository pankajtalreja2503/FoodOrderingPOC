//
//  NSManageObjectContext+Extention.swift
//  CoffeeAPP
//
//  Created by Pankaj Talreja on 16/03/21.
//

import Foundation
import UIKit
import CoreData

extension NSManagedObjectContext {
    static var currentContext: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
        
    }
    
}
