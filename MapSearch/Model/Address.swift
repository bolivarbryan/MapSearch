//
//  Address.swift
//  MapSearch
//
//  Created by Bryan on 7/02/17.
//  Copyright © 2017 BolivarBryan. All rights reserved.
//

import Foundation

//I choose to not use CLLocationCoordinate2D, for prevent importing frameworks in model section
typealias Coordinate = (latitude: Double, longitude:Double)

struct Address {
    var name: String
    var formattedAddress: String
    var location: Coordinate
    var placeID:String

    init(name: String, formattedAddress:String, location: Coordinate, placeID: String) {
        self.name = name
        self.formattedAddress = formattedAddress
        self.placeID = placeID
        
        if (location.latitude < 90) && (location.latitude > -90) && (location.longitude < 180) && (location.longitude > -180) {
            self.location = location
        }else{
            self.location.latitude = 0
            self.location.longitude = 0
        }
    }
}
