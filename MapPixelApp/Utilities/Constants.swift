//
//  Constants.swift
//  MapPixelApp
//
//  Created by Teja PV on 8/1/18.
//  Copyright © 2018 Teja PV. All rights reserved.
//

import Foundation
let FLICKR_API_KEY = "4a33c3bd3dc1dbfa705a64bf53c8ae3d"
func flickrURL(forAPIKey key: String, withAnnotation annotation: DropPin, numberofPhotos number: Int) -> String{
     return "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(FLICKR_API_KEY)&lat=\(annotation.coordinate.latitude)&lon=\(annotation.coordinate.longitude)&radius=1&radius_units=mi&per_page=\(number)&format=json&nojsoncallback=1"
}
let FLICKR_API_URL = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=b6b8d25fb5b00c21665edea2bf3398b2&lat=42.8&lon=122.8&radius=1&radius_units=mi&per_page=50&format=json&nojsoncallback=1"
