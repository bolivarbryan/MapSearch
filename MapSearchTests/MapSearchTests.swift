//
//  MapSearchTests.swift
//  MapSearchTests
//
//  Created by Bryan on 7/02/17.
//  Copyright © 2017 BolivarBryan. All rights reserved.
//

import XCTest
@testable import MapSearch

class MapSearchTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAddressCoordinate_ShouldBeAValidCoordinate() {
        // given
        let latitude = 100.0
        let longitude = 300.0
        let name = "test"
        let formattedAddress = "Barranquilla Colombia"
        let placeID = "X0X0X0"
        //when
        let acceptedValue = 80.0
        let address = Address(name: name, formattedAddress: formattedAddress, location: (latitude, longitude), placeID: placeID)
        //then
        XCTAssertTrue(address.location.latitude < acceptedValue, "Latitude should be less than \(acceptedValue)")
    }
    
    func testAddressPlaceID_ShouldHaveADifferentID() {
        
    }
}
