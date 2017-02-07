//
//  DatabaseManager.swift
//  MapSearch
//
//  Created by Bryan on 7/02/17.
//  Copyright © 2017 BolivarBryan. All rights reserved.
//

import Foundation
import CoreData

struct DatabaseManager {
    
    enum ProggressStatus {
        case Success
        case Error
    }
    
    static func saveAddress(parameters: Address, entity: String, completion: ((_ result : ProggressStatus ) -> Void)) {
        
    }
    
    static func listAllAddresses() -> [Address] {
        return []
    }
    
    static func findAddressInDatabase(address: Address) -> Address? {
        return nil
    }
}
