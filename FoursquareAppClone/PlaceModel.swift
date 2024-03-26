//
//  PlaceModel.swift
//  FoursquareAppClone
//
//  Created by Metehan Canpolat on 23.03.2024.
//

import Foundation
import UIKit

class PlaceModel {
    
    static let sharedInstance = PlaceModel()
    
    var placeName = ""
    var placeType = ""
    var placeComment = ""
    var placeImage = UIImage()
    var placeLatitude = ""
    var placeLongitute = ""
    
    
    private init(){}
    
}
