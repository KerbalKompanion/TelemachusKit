//
//  File.swift
//  
//
//  Created by Noah Kamara on 10.03.20.
//

import Foundation

/// Decodes received TelemachusData
public struct JsonModel: Decodable {
    let version: String
    let ip: [String]
    let gameStatus: Int //p.paused
    let universalTime: Double
    let missionTime: Double
    let name: String
    let altitude: Double
    let heightFromTerrain: Double
    let throttle: Double
    let sas: QuantumValue
    let rcs: QuantumValue
    let gear: QuantumValue
    let light: QuantumValue
    let brake: QuantumValue
    let roll: Double
    let heading: Double
    let pitch: Double
    let verticalSpeed: Double
    let velocity: Double
    
    let terrainHeight: Double
    
    let atmosphericDensity: Double
    let gforce: Double
    
    let longitude: Double
    let latitude: Double
    
    let ressourceList: [String]
    let liquidFuelCurrent: Double
    let liquidFuelMax: Double
    let electricChargeCurrent: Double
    let electricChargeMax: Double
    let intakeAirCurrent: Double
    let intakeAirMax: Double
    
    let tempSensor: SensorValue
    let presSensor: SensorValue
    let accSensor: SensorValue
    let gravSensor: SensorValue
    
    let targetName: String
    let targetType: String
    let targetDistance: Double
    let targetVelocity: Double
    let targetRelativeVelocity: Double
    
    
    enum CodingKeys: String, CodingKey {
        case version = "a.version"
        case ip = "a.ip"
        case gameStatus = "p.paused"
        case universalTime = "t.universalTime"
        case missionTime =  "v.missionTime"
        case name = "v.name"
        case altitude = "v.altitude"
        case heightFromTerrain = "v.heightFromTerrain"
        case throttle = "f.throttle"
        case sas = "v.sasValue"
        case rcs = "v.rcsValue"
        case gear = "v.gearValue"
        case light = "v.lightValue"
        case brake = "v.brakeValue"
        case roll = "n.roll"
        case heading = "n.heading"
        case pitch = "n.pitch"
        case verticalSpeed = "v.verticalSpeed"
        case velocity = "v.surfaceVelocity"
        
        case terrainHeight = "v.terrainHeight"
        
        case atmosphericDensity = "v.atmosphericDensity"
        case gforce = "v.geeForce"
        
        case longitude = "v.long"
        case latitude = "v.lat"
        
        case ressourceList = "r.resourceNameList"
        case liquidFuelCurrent = "r.resource[LiquidFuel]"
        case liquidFuelMax = "r.resourceMax[LiquidFuel]"
        case electricChargeCurrent = "r.resource[ElectricCharge]"
        case electricChargeMax = "r.resourceMax[ElectricCharge]"
        case intakeAirCurrent = "r.resource[IntakeAir]"
        case intakeAirMax = "r.resourceMax[IntakeAir]"
        
        case tempSensor = "s.sensor.temp"
        case presSensor = "s.sensor.pres"
        case accSensor = "s.sensor.acc"
        case gravSensor = "s.sensor.grav"
        
        case targetName = "tar.name"
        case targetType = "tar.type"
        case targetDistance = "tar.distance"
        case targetVelocity = "tar.o.velocity"
        case targetRelativeVelocity = "tar.o.relativeVelocity"
    }
    
}


/// Can be used for Decodable where vlue can be either Double or Sensor Error
enum SensorValue: Decodable {
    case double(Double), null(Double?)
    init(from decoder: Decoder) throws {
        if let double = try? decoder.singleValueContainer().decode(Double.self) {
            self = .double(double)
            return
        } else {
            self = .null(nil)
            return
        }

    }

    enum SensorError:Error {
        case missingValue
    }
}

/// Can be used for Decodable where vlue can be either Boolean or Integer (Dont thank me thank the devs of Telemachus, who made their otherwise perfectly fine Websocket return a f*cking QuantumValue :D PS: Still love you for the mod but come on!
enum QuantumValue: Decodable {
    case bool(Bool), int(Int)
    init(from decoder: Decoder) throws {
        if let bool = try? decoder.singleValueContainer().decode(Bool.self) {
            self = .bool(bool)
            return
        }

        if let int = try? decoder.singleValueContainer().decode(Int.self) {
            self = .int(int)
            return
        }

        throw QuantumError.missingValue
    }

    enum QuantumError:Error {
        case missingValue
    }
}
