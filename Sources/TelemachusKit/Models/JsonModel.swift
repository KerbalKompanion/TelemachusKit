//
//  File.swift
//  
//
//  Created by Noah Kamara on 10.03.20.
//

import Foundation

/// Decodes received TelemachusData
public struct JsonModel: Decodable {
    let gameStatus: Int //p.paused
    let universalTime: Double
    let missionTime: Double
    let altitude: Double
    let heightFromTerrain: Double
    let gear: QuantumValue
    let light: QuantumValue
    let brake: QuantumValue
    let roll: Double
    let heading: Double
    let pitch: Double
    let verticalSpeed: Double
    let velocity: Double
    let liquidFuelCurrent: Double
    let liquidFuelMax: Double
    let targetName: String
    let targetType: String
    let targetDistance: Double
    let targetVelocity: Double
    let targetRelativeVelocity: Double
    
    
    enum CodingKeys: String, CodingKey {
        case gameStatus = "p.paused"
        case universalTime = "t.universalTime"
        case missionTime =  "v.missionTime"
        case altitude = "v.altitude"
        case heightFromTerrain = "v.heightFromTerrain"
        case gear = "v.gearValue"
        case light = "v.lightValue"
        case brake = "v.brakeValue"
        case roll = "n.roll"
        case heading = "n.heading"
        case pitch = "n.pitch"
        case verticalSpeed = "v.verticalSpeed"
        case velocity = "v.surfaceVelocity"
        case liquidFuelCurrent = "r.resource[LiquidFuel]"
        case liquidFuelMax = "r.resourceMax[LiquidFuel]"
        case targetName = "tar.name"
        case targetType = "tar.type"
        case targetDistance = "tar.distance"
        case targetVelocity = "tar.o.velocity"
        case targetRelativeVelocity = "tar.o.relativeVelocity"
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
