//
//  TelemachusData.swift
//  
//
//  Created by Noah Kamara on 10.03.20.
//

import Foundation

public class TelemachusData {
    
    /// DateFormatter for dateStrings
    private var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        return formatter
    }
    
    /// Reference Date (01.01.0001 for KSP)
    private var referenceDate: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        return formatter.date(from: "0001/01/01 00:00")!
    }
    
    /// Initializes an empty TelemachusData Model
    public init() {}
    
    /// Initializes an TelemachusData Model with a JsonModel
    public init(_ json: JsonModel) {
        self.gameStatus                        = GameStatus(rawValue: json.gameStatus) ?? .error
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
    
    /// Game Status of TelemachusAntenna
    var gameStatus: GameStatus                      = .error
    
    /// The passed time of the game save (in seconds)
    var universalTimeInterval: TimeInterval         = 0
    
    /// The universalTime relative to the reference Date
    var universalTime: Date {
        get { return Date(timeInterval: universalTimeInterval, since: referenceDate) }
    }
    
    /// The passed time of the current mission (in seconds)
    var missionTimeInterval: TimeInterval = 0
    /// The missionTime relative to the reference Date
    var missionTime: Date {
        get { return Date(timeInterval: missionTimeInterval, since: referenceDate) }
    }
    
    /// Information about the current Vessel
    var vessel: Vessel                  = Vessel()
    
    /// Information about the Vessel's target
    var target: Target?                 = nil
    
    
    /// Enum representing the Game Status
    public enum GameStatus: Int {
        case inFlight   = 0
        case paused     = 1
        case noPower    = 2
        case disabled   = 3
        case notFound   = 4
        case error      = 99
    }
    
    /// Vessel Information Struct
    public struct Vessel {
        
        /// Returns true if the remaining liquid fuel is below 10% of the max fuel
        var lowFuelWarning: Bool {
            get { return (ressource.liquid.current / ressource.liquid.max < 0.1) }
        }
        /// Returns true if the remaining liquid fuel is below 50% of the max fuel
        var lowAltitudeWarning: Bool {
            get { return (heightFromTerrain < 50 && gear == false) }
        }
        
        /// The name of the current vessel
        var name: String                = ""
        
        /// The altitude relative to sea level
        var altitude: Double            = 0.0
        
        /// Altitude relative to the terrain height
        var heightFromTerrain: Double   = 0.0
        
        /// Status of the gear
        /// true: Gear down
        /// false: Gear up
        var gear: Bool                  = false
        
        /// Status of the light
        /// true: lights on
        /// false: lights off
        var light: Bool                 = false
        
        /// Status of the brakes
        /// true: brakes engaged
        /// false: brakes disengaged
        var brake: Bool                 = false
        
        /// The attitude (roll, pitch, heading)
        var attitude: Attitude          = Attitude()
        
        /// The Speed (vertical, surface)
        var speed: Speed                = Speed()
        
        /// Info about ressources
        var ressource: Ressource        = Ressource()
        
        
        /// Attitude Struct
        public struct Attitude {
            var roll: Double            = 0.0
            var heading: Double         = 0.0
            var pitch: Double           = 0.0
        }
        
        /// Speed Struct
        public struct Speed {
            /// vertical speed (difference in altitude)
            var vertical: Double        = 0.0
            /// surface speed
            var surface: Double         = 0.0
        }
        
        /// Ressource Struct
        public struct Ressource {
            var liquid: Fuel            = Fuel()
            
            /// Information about a fuel
            struct Fuel {
                /// Current fuel amount
                var current: Double     = 0.0
                /// maximum fuel amount
                var max: Double         = 0.0
                /// percentage of fuel left (relative to max)
                var remaining: Double {
                   get { return (current / max) }
                }
            }
        }
    }
    
    
    /// Target Struct
    public struct Target {
        /// Name of the target
        var name: String
        /// Type of the target
        var type: String
        /// Distance from the target
        var distance: Double
        /// Targets velocity
        var velocity: Double
        /// Targets velocity relative to current vessel
        var relativeVelocity: Double
    }
}
