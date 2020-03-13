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
        case gameStatus = "p.paused"
        case universalTime = "t.universalTime"
        case missionTime = "v.missionTime"
        
        case heightFromTerrain = "v.heightFromTerrain"
        case altitude = "v.altitude"
        
        case verticalSpeed = "v.verticalSpeed"
        case surfaceVelocity = "v.surfaceVelocity"
        
        
        case gearValue = "v.gearValue"
        case brakeValue = "v.brakeValue"
        case lightValue = "v.lightValue"
        
        
        case heading = "n.heading"
        case roll = "n.roll"
        case pitch = "n.pitch"
        
        case liquidFuelCurrent = "r.resource[LiquidFuel]"
        case liquidFuelMax = "r.resourceMax[LiquidFuel]"
        
        case targetName = "tar.name"
        case targetType = "tar.type"
        case targetDistance = "tar.distance"
        case targetVelocity = "tar.o.velocity"
        case targetRelativeVelocity = "tar.o.relativeVelocity"
    }
}
