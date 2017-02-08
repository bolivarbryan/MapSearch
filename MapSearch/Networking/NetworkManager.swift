//
//  NetworkManager.swift
//  MapSearch
//
//  Created by Bryan on 7/02/17.
//  Copyright © 2017 BolivarBryan. All rights reserved.
//

import Foundation
import Alamofire

let kGMapsApiKey = "AIzaSyDvZuBgB7g3BzlU9Wc11RQG_61vUvAEIjo"

//MARK: ENDPOINTS
private let kUrlMaps = "https://maps.googleapis.com/maps/api/geocode/json?sensor=false&key=\(kGMapsApiKey)&address="

struct NetworkManager {

    
    //MARK: REQUESTS
    static func listPlacesUsingAlamofire(withName name:String, completion: @escaping (_ results: Dictionary<String, Any>) -> Void)  {
        Alamofire.request("\(kUrlMaps)\(name.replacingOccurrences(of: " ", with: "+"))").responseJSON { response in
            if let JSON = response.result.value {
                completion(["results": JSON])
            }
    }
    
    }
}
