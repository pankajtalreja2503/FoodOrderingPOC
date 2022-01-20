//
//  CoreDataManager.swift
//  CoffeeAPP
//
//  Created by Pankaj Talreja on 15/03/21.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    static let shared = CoreDataManager(moc: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
    
    var moc: NSManagedObjectContext
    private init(moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    ///Save the Order details for next Page
    func saveOrde(categoryName: String, price: Double, quantity: Int, name: String, imageURL: String) {
        let order = Order(context: self.moc)
        order.categoryName = categoryName
        order.price = price
        order.quantity = Int16(quantity)
        order.name = name
        order.imageURL = imageURL
        do {
            print("\(order) order object")
            try self.moc.save()
            print("Orer save")
        } catch {
            print(error)
        }
    }
    
    ///Actual save operation in the CoreData
    func save() {
        do {
            try self.moc.save()
            print("Orer save")
        } catch {
            print(error)
        }
    }
    
    ///Fetch the order from Core Data
    func fetchOrder(withName name: String) -> Order? {
        var orders = [Order]()
        let request: NSFetchRequest<Order> = Order.fetchRequest()
        request.predicate = NSPredicate(format: "name = %@", name)
        do {
            orders = try self.moc.fetch(request)
        } catch  {
            print(error)
        }
        return orders.first
    }
    
    ///Delete the order from Core data
    func deleteOrder(name: String){
        do {
            if let order = fetchOrder(withName: name) {
                self.moc.delete(order)
                try self.moc.save()
            }
        } catch {
            print(error)
        }
    }
    
    ///get all the orders
    func getAllOrders()-> [Order] {
        var orders = [Order]()
        let orderRequest: NSFetchRequest<Order> = Order.fetchRequest()
        
        do  {
            orders = try self.moc.fetch(orderRequest)
            print(orders)
        } catch {
            print(error)
        }
        return orders
    }
    
func deleteAllData() {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Order")
    fetchRequest.returnsObjectsAsFaults = false

    do
    {
        let results = try managedContext.fetch(fetchRequest)
        for managedObject in results
        {
            let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
            managedContext.delete(managedObjectData)
        }
    } catch let error as NSError {
        print("Delete all data in Order error : \(error) \(error.userInfo)")
    }
}
    
}
