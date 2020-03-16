//
//  File.swift
//  
//
//  Created by Noah Kamara on 10.03.20.
//

import Foundation

extension TelemachusClient {
    
    /// API-Strings for Telemachus Websocket API
    public enum ApiKey: String, CaseIterable {
        /// Game Status
        case gameStatus = "p.paused"
        /// Universal Time
        case universalTime = "t.universalTime"
        /// Mission Time
        case missionTime = "v.missionTime"
        
        /// Vessel Name
        case name = "v.name"
        /// Height from Terrain
        case heightFromTerrain = "v.heightFromTerrain"
        /// Altitude
        case altitude = "v.altitude"
        
        /// Vertical Speed
        case verticalSpeed = "v.verticalSpeed"
        /// Surface Speed
        case surfaceVelocity = "v.surfaceVelocity"
        
        /// Throttle in percent
        case throttle = "f.throttle"
        /// SAS
        case sasValue = "v.sasValue"
        /// RCS
        case rcsValue = "v.rcsValue"
        /// Gear
        case gearValue = "v.gearValue"
        /// Brake
        case brakeValue = "v.brakeValue"
        /// Lights
        case lightValue = "v.lightValue"
        
        /// Heading
        case heading = "n.heading"
        /// Roll
        case roll = "n.roll"
        /// Pitch
        case pitch = "n.pitch"
        
        /// Ressource List
        case ressourceList = "r.resourceNameList"
        
        /// Liquid Fuel - Current Amount
        case liquidFuelCurrent = "r.resource[LiquidFuel]"
        /// Liquid Fuel - Max Amount
        case liquidFuelMax = "r.resourceMax[LiquidFuel]"
        
        /// Electric Charge - Current Amount
        case electricChargeCurrent = "r.resource[ElectricCharge]"
        /// Electric Charge - Max Amount
        case electricChargeMax = "r.resourceMax[ElectricCharge]"
        
        /// Intake Air - Current Amount
        case intakeAirCurrent = "r.resource[IntakeAir]"
        /// Intake Air - Max Amount
        case intakeAirMax = "r.resourceMax[IntakeAir]"
        
        
        /// Temperature Sensor Data
        case tempSensor = "s.sensor.temp"
        
        /// Pressure Sensor Data
        case presSensor = "s.sensor.pres"
        
        /// Acceleration Sensor Data
        case accSensor = "s.sensor.acc"
        
        /// Gravitation Sensor Data
        case gravSensor = "s.sensor.grav"
        
        
        /// Target: Name
        case targetName = "tar.name"
        /// Target: Type
        case targetType = "tar.type"
        /// Target: Distance
        case targetDistance = "tar.distance"
        /// Target: velocity
        case targetVelocity = "tar.o.velocity"
        /// Target: Relative Velocity
        case targetRelativeVelocity = "tar.o.relativeVelocity"
    }
}
