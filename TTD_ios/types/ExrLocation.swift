//
//  ExrLocation.swift
//  TTD_ios
//
//  Created by Attila Janosi on 16/10/2019.
//  Copyright © 2019 EXERA SOTDEVELOP SRL. All rights reserved.
//

import UIKit

class ExrLocation {
    static let TAG = "SensorLocation"
    static let latitude = "latitude"
    static let longitude = "longitude"
    static let date = "date"
    static let accuracy = "accuracy"
    static let speed = "speed"
    static let bearing = "bearing"
    static let gps_strength = "gpsStrength"
    static let satellite_number = "sattelite_number"
    static let extraJSON = "extraJSON"
    
    var latitudeValue = 0.0
    var longitudeValue = 0.0
    var dateValue: Int32 = 0
    var accuracyValue: Double = 0.0
    var speedValue = 0
    var bearingValue = 0
    var gpsStrengthValue = 0
    var satelliteNumberValue = 0
    var extraJSON_Value = ""
    
    static func getLocationFromSnapshot(snapshot: [String : AnyObject]) -> ExrLocation {
        let location = ExrLocation()
        location.latitudeValue = snapshot[ExrLocation.latitude] as? Double ?? 0.0
        location.longitudeValue = snapshot[ExrLocation.longitude] as? Double ?? 0.0
        location.dateValue = snapshot[ExrLocation.date] as? Int32 ?? 0
        location.accuracyValue = snapshot[ExrLocation.accuracy] as? Double ?? 0.0
        location.speedValue = snapshot[ExrLocation.speed] as? Int ?? 0
        location.bearingValue = snapshot[ExrLocation.bearing] as? Int ?? 0
        location.gpsStrengthValue = snapshot[ExrLocation.gps_strength] as? Int ?? 0
        location.satelliteNumberValue = snapshot[ExrLocation.satellite_number] as? Int ?? 0
        location.extraJSON_Value = snapshot[ExrLocation.extraJSON] as? String ?? ""
        return location
    }
}
