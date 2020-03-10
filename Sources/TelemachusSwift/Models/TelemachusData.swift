//
//  File.swift
//  
//
//  Created by Noah Kamara on 10.03.20.
//

import Foundation

class TelemachusData {
    private var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        return formatter
    }
    
    private var referenceDate: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        return formatter.date(from: "0001/01/01 00:00")!
    }
    var universalTimeInterval: TimeInterval         = 0
    var universalTime: Date {
        get { return Date(timeInterval: universalTimeInterval, since: referenceDate) }
    }
    
    init(_ json: JsonModel) {
        self.universalTimeInterval             = json.universalTime
        self.missionTimeInterval               = json.missionTime
        self.vessel.name                       = "realName"
        self.vessel.altitude                   = json.altitude
        self.vessel.heightFromTerrain          = json.heightFromTerrain
        self.vessel.gear                       = json.gear
        self.vessel.light                      = json.light
        self.vessel.brake                      = json.brake
        
        self.vessel.attitude.roll              = json.roll
        self.vessel.attitude.heading           = json.heading
        self.vessel.attitude.pitch             = json.pitch
        
        self.vessel.speed.vertical             = json.verticalSpeed
        self.vessel.speed.surface              = json.velocity
        
        self.vessel.ressource.liquid.current   = json.liquidFuelCurrent
        self.vessel.ressource.liquid.max       = json.liquidFuelMax
    }
    
    
    
    var missionTimeInterval: TimeInterval = 0
    var missionTime: Date {
        get { return Date(timeInterval: missionTimeInterval, since: referenceDate) }
    }
    
    var vessel: Vessel                  = Vessel()
    var target: Target?                 = nil
    
    struct Vessel {
        var lowFuelWarning: Bool {
            get { return (ressource.liquid.current / ressource.liquid.max < 0.1) }
        }
        var lowAltitudeWarning: Bool {
            get { return (heightFromTerrain < 50 && gear == false) }
        }
        
        var name: String                = ""
        var altitude: Double            = 0.0
        var heightFromTerrain: Double   = 0.0
        var gear: Bool                  = false
        var light: Bool                 = false
        var brake: Bool                 = false
        var attitude: Attitude          = Attitude()
        var speed: Speed                = Speed()
        var ressource: Ressource        = Ressource()
        struct Attitude {
            var roll: Double            = 0.0
            var heading: Double         = 0.0
            var pitch: Double           = 0.0
        }
        struct Speed {
            var vertical: Double        = 0.0
            var surface: Double         = 0.0
        }
        struct Ressource {
            var liquid: Fuel            = Fuel()
            struct Fuel {
                var current: Double     = 0.0
                var max: Double         = 0.0
                var remaining: Double {
                   get { return (current / max) }
                }
            }
        }
    }
    
    struct Target {
        var name: String
        var type: String
        var distance: Double
        var velocity: Double
        var relativeVelocity: Double
    }
}
