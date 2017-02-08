//
//  DatabaseManager.swift
//  MapSearch
//
//  Created by Bryan on 7/02/17.
//  Copyright © 2017 BolivarBryan. All rights reserved.
//

import Foundation
import CoreData
import UIKit

private let sharedDatabase = DatabaseManager()

class DatabaseManager {
    enum ProggressStatus: String {
        case success = "Success"
        case error  = "Error"
        case alreadySaved  = "Registry already Saved"
    }

    class var sharedInstance: DatabaseManager {
        return sharedDatabase
    }
    
    func saveAddress(address: Address, completion: ((_ result : ProggressStatus ) -> Void)) {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        //verify there is not a same place in database
        if self.findAddressInDatabase(address: address) == nil {
            if #available(iOS 10.0, *) {
                let managedContext = appDelegate.persistentContainer.viewContext
                let entity =  NSEntityDescription.entity(forEntityName: "Location", in: managedContext)!
                let addressObject = NSManagedObject(entity: entity, insertInto: managedContext)
                addressObject.setValue(address.name, forKeyPath: "name")
                addressObject.setValue(address.formattedAddress, forKeyPath: "formattedAddress")
                addressObject.setValue(address.location.longitude, forKeyPath: "longitude")
                addressObject.setValue(address.location.latitude, forKeyPath: "latitude")
                addressObject.setValue(address.placeID, forKeyPath: "placeID")
                
                do {
                    try managedContext.save()
                    completion(ProggressStatus.success)
                } catch let error as NSError {
                    print("Save Error. \(error), \(error.userInfo)")
                    completion(ProggressStatus.error)
                }
                
            } else {
                // Fallback on earlier versions
            }
        }else {
            //already saved
            completion(ProggressStatus.alreadySaved)
        }

    }
    
    func listAllAddresses() -> [Address] {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return []
        }
        
        if #available(iOS 10.0, *) {
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest =
                NSFetchRequest<NSManagedObject>(entityName: "Location")
            do {
               let addressObjects = try managedContext.fetch(fetchRequest)
                var addresses:[Address] = []
                for addressObject in addressObjects {
                    print(addressObject)
                    let address = Address(name: addressObject.value(forKey: "name") as! String, formattedAddress: addressObject.value(forKey: "formattedAddress") as! String, location: (addressObject.value(forKey: "latitude") as! Double, addressObject.value(forKey: "longitude") as! Double), placeID: addressObject.value(forKey: "placeID") as! String)
                        addresses.append(address)
                }
                return addresses
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
                return []
            }
        } else {
            // Fallback on earlier versions
            
            return []
        }
    }
    
    func findAddressInDatabase(address: Address) -> Address? {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return nil
        }
        
        if #available(iOS 10.0, *) {
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest =
                NSFetchRequest<NSManagedObject>(entityName: "Location")
            fetchRequest.predicate = NSPredicate(format: "placeID == %@", address.placeID)
            do {
                let addressObjects = try managedContext.fetch(fetchRequest)
                for addressObject in addressObjects {
                    return Address(name: addressObject.value(forKey: "name") as! String, formattedAddress: addressObject.value(forKey: "formattedAddress") as! String, location: (addressObject.value(forKey: "latitude") as! Double, addressObject.value(forKey: "longitude") as! Double), placeID: addressObject.value(forKey: "placeID") as! String)
                }
                return nil
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
                return nil
            }
        } else {
            // Fallback on earlier versions
            return nil
        }
    }
    
    func deleteAddress(address: Address) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        if #available(iOS 10.0, *) {
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest =
                NSFetchRequest<NSManagedObject>(entityName: "Location")
            fetchRequest.predicate = NSPredicate(format: "placeID == %@", address.placeID)
            do {
                let addressObjects = try managedContext.fetch(fetchRequest)
                if addressObjects.count > 0 {
                    managedContext.delete(addressObjects[0])
                }
                } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
                return
            }
        } else {
            // Fallback on earlier versions
            return
        }
    }
}
