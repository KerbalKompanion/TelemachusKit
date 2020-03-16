//
//  TelemachusData.swift
//  
//
//  Created by Noah Kamara on 10.03.20.
//

import Foundation


/// Class for Holding FlightData from KSP
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
        self.vessel.name                       = json.name
        self.vessel.altitude                   = json.altitude
        self.vessel.heightFromTerrain          = json.heightFromTerrain
        self.vessel.throttle                   = json.throttle
        switch json.sas {
            case .bool(let value): self.vessel.sas = value
            default: break
        }
        
        switch json.rcs {
            case .bool(let value): self.vessel.rcs = value
            default: break
        }
        
        switch json.gear {
            case .bool(let value): self.vessel.gear = value
            default: break
        }
        
        switch json.light {
            case .bool(let value): self.vessel.light = value
            default: break
        }
        
        switch json.brake {
            case .bool(let value): self.vessel.brake = value
            default: break
        }
        
        self.vessel.attitude.roll              = json.roll
        self.vessel.attitude.heading           = json.heading
        self.vessel.attitude.pitch             = json.pitch
        
        self.vessel.speed.vertical             = json.verticalSpeed
        self.vessel.speed.surface              = json.velocity
        
        self.vessel.ressource.liquid.current   = json.liquidFuelCurrent
        self.vessel.ressource.liquid.max       = json.liquidFuelMax
        
        self.vessel.ressource.electricCharge.current   = json.electricChargeCurrent
        self.vessel.ressource.electricCharge.max       = json.electricChargeMax
        
        self.vessel.ressource.intakeAir.current   = json.intakeAirCurrent
        self.vessel.ressource.intakeAir.max       = json.intakeAirMax
        
        switch json.accSensor {
            case .double(let value): self.sensors.acceleration = value
            default: break
        }
        switch json.gravSensor {
            case .double(let value): self.sensors.gravitation = value
            default: break
        }
        switch json.presSensor {
            case .double(let value): self.sensors.pressure = value
            default: break
        }
        switch json.tempSensor {
            case .double(let value): self.sensors.temperature = value
            default: break
        }
        
        
        if json.targetName != "" {
            self.target = Target()
            self.target!.name = json.targetName
            self.target!.type = json.targetType
            self.target!.distance = json.targetDistance
            self.target!.velocity = json.targetVelocity
            self.target!.relativeVelocity = json.targetRelativeVelocity
        } else {
            self.target = nil
        }
    }
    
    /// Game Status of TelemachusAntenna
    public var gameStatus: GameStatus                      = .error
    
    /// The passed time of the game save (in seconds)
    var universalTimeInterval: TimeInterval         = 0
    
    /// The universalTime relative to the reference Date
    public var universalTime: Date {
        get { return Date(timeInterval: universalTimeInterval, since: referenceDate) }
    }
    
    /// The passed time of the current mission (in seconds)
    var missionTimeInterval: TimeInterval = 0
    /// The missionTime relative to the reference Date
    public var missionTime: Date {
        get { return Date(timeInterval: missionTimeInterval, since: referenceDate) }
    }
    
    /// Information about the current Vessel
    public var vessel: Vessel                  = Vessel()
    
    /// Information about environment sensors (Data)
    public var sensors: SensorData             = SensorData()
    
    /// Information about the Vessel's target
    public var target: Target?                 = nil
    
    
    /// Enum representing the Game Status
    public enum GameStatus: Int {
        /// game is running and vessel is in flight
        case inFlight   = 0
        /// game is paused
        case paused     = 1
        /// TelemachusAntenna doesnt have power
        case noPower    = 2
        /// TelemachusAntenna is disabled
        case disabled   = 3
        /// TelemachusAntenna not on board
        case notFound   = 4
        /// KSP not in Flight
        case noVessel   = 5
        /// Error (not send by Telemachus)
        case error      = 99
    }
    
    /// Vessel Information Struct
    public struct Vessel {
        
        /// Returns true if the remaining liquid fuel is below 10% of the max fuel
        public var lowFuelWarning: Bool {
            get { return (ressource.liquid.current / ressource.liquid.max < 0.1) }
        }
        /// Returns true if the remaining liquid fuel is below 50% of the max fuel
        public var lowAltitudeWarning: Bool {
            get { return (heightFromTerrain < 50 && gear == false) }
        }
        
        /// The name of the current vessel
        public var name: String                = ""
        
        /// The altitude relative to sea level
        public var altitude: Double            = 0.0
        
        /// Altitude relative to the terrain height
        public var heightFromTerrain: Double   = 0.0
        
        /// Status of the SAS
        /// true: SAS on
        /// false: SAS off
        public var sas: Bool                  = false
        
        /// Status of the RCS
        /// true: RCS on
        /// false: RCS off
        public var rcs: Bool                  = false
        
        /// Status of the gear
        /// true: Gear down
        /// false: Gear up
        public var gear: Bool                  = false
        
        /// Status of the light
        /// true: lights on
        /// false: lights off
        public var light: Bool                 = false
        
        /// Status of the brakes
        /// true: brakes engaged
        /// false: brakes disengaged
        public var brake: Bool                 = false
        
        /// The attitude (roll, pitch, heading)
        public var attitude: Attitude          = Attitude()
        
        
        /// The engine throttle in percent
        public var throttle: Double            = 0.0
        
        /// The Speed (vertical, surface)
        public var speed: Speed                = Speed()
        
        /// Info about ressources
        public var ressource: Ressource        = Ressource()
        
        
        /// Attitude Struct
        public struct Attitude {
            
            /// Roll of the Vessel
            public var roll: Double            = 0.0
            
            /// heading of the Vessel
            public var heading: Double         = 0.0
            
            /// pitch of the Vessel
            public var pitch: Double           = 0.0
        }
        
        /// Speed Struct
        public struct Speed {
            /// vertical speed (difference in altitude)
            public var vertical: Double        = 0.0
            /// surface speed
            public var surface: Double         = 0.0
        }
        
        /// Ressource Struct
        public struct Ressource {
            /// Liquid Fuel Ressource
            public var liquid: Fuel            = Fuel()
            public var electricCharge: Fuel    = Fuel()
            public var intakeAir: Fuel         = Fuel()
            /// Information about a fuel
            public struct Fuel {
                /// Current fuel amount
                public var current: Double     = 0.0
                /// maximum fuel amount
                public var max: Double         = 0.0
                /// percentage of fuel left (relative to max)
                public var remaining: Double {
                    get {
                        if self.max == 0.0 {
                            return 0.0
                        }
                        return (current / max)
                    }
                }
            }
        }
    }
    
    /// Sensor Data Struct
    public struct SensorData {
        /// Temperature Sensor Data
        public var temperature: Double?        = nil
        /// Pressure Sensor Data
        public var pressure: Double?           = nil
        /// Acceleration Sensor Data
        public var acceleration: Double?       = nil
        /// Gravitation Sensor Data
        public var gravitation: Double?        = nil
        
        /// An Array of SensorTypes (the available sensors)
        public var availableSensors: [SensorType] {
            var available: [SensorType] = []
            if self.temperature != nil {
                available.append(.temperature)
            }
            if self.pressure != nil {
                available.append(.pressure)
            }
            if self.acceleration != nil {
                available.append(.acceleration)
            }
            if self.gravitation != nil {
                available.append(.gravitation)
            }
            return available
        }
        
        /// Sensor Type Enum
        public enum SensorType {
            /// Temperature Sensor
            case temperature
            /// Pressure Sensor
            case pressure
            /// Acceleration Sensor
            case acceleration
            /// Gravitation Sensor
            case gravitation
        }
        
    }
    /// Target Struct
    public struct Target {
        /// Name of the target
        public var name: String                = ""
        /// Type of the target
        public var type: String                = ""
        /// Distance from the target
        public var distance: Double            = 0.0
        /// Targets velocity
        public var velocity: Double            = 0.0
        /// Targets velocity relative to current vessel
        public var relativeVelocity: Double    = 0.0
    }
}
