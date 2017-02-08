//
//  APIRequests.swift
//  MapSearch
//
//  Created by Bryan on 7/02/17.
//  Copyright © 2017 BolivarBryan. All rights reserved.
//

import Foundation

private let sharedInstance = APIRequests()

class APIRequests {

    class var sharedInstance: DatabaseManager {
        return self.sharedInstance
    }
    
    class func listPlacesWithName(name: String, completion: @escaping (_ result: [Address]) -> Void ) {
        var places: [Address] = []
        NetworkManager.listPlacesUsingAlamofire(withName: name) { (response) in
            let responseDictionary = response["results"] as! Dictionary<String, Any>

            for addressObject in responseDictionary["results"] as! Array<Dictionary<String, Any>> {
                let geometry = addressObject["geometry"] as! Dictionary<String, Any>
                let latitude = (geometry["location"] as! Dictionary<String, Any>)["lat"] as! Double
                let longitude = (geometry["location"] as! Dictionary<String, Any>)["lng"] as! Double
                let formattedAddress = addressObject["formatted_address"] as! String
                let name = ((addressObject["address_components"] as! Array<Dictionary<String, Any>>)[0])["long_name"] as! String
                let placeID = addressObject["place_id"] as! String
                let place = Address(name: name, formattedAddress: formattedAddress, location: (latitude, longitude), placeID: placeID)
                
                places.append(place)
            }
            completion(places)
        }
    }
}
