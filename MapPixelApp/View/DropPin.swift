//
//  DropPin.swift
//  MapPixelApp
//
//  Created by Teja PV on 7/24/18.
//  Copyright © 2018 Teja PV. All rights reserved.
//

import Foundation
import MapKit
class DropPin : NSObject, MKAnnotation{
    var coordinate : CLLocationCoordinate2D
    var identifier : String
    init(coordinate : CLLocationCoordinate2D, identifier : String) {
        self.coordinate = coordinate
        self.identifier = identifier
        super.init()
    }
}
