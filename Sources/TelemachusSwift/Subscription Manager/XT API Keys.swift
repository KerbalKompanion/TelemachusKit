//
//  File.swift
//  
//
//  Created by Noah Kamara on 10.03.20.
//

import Foundation

extension SubscriptionManager {
    enum ApiKey: CaseIterable {
        static let universalTime = "t.universalTime"
        static let missionTime = "v.missionTime"
        
        static let heightFromTerrain = "v.heightFromTerrain"
        static let altitude = "v.altitude"
        
        static let verticalSpeed = "v.verticalSpeed"
        static let surfaceVelocity = "v.surfaceVelocity"
        
        
        static let gearValue = "v.gearValue"
        static let brakeValue = "v.brakeValue"
        static let lightValue = "v.lightValue"
        
        
        static let heading = "n.heading"
        static let roll = "n.roll"
        static let pitch = "n.pitch"
        
        static let liquidFuelCurrent = "r.resource[LiquidFuel]"
        static let liquidFuelMax = "r.resourceMax[LiquidFuel]"
        
        static let targetName = "tar.name"
        static let targetType = "tar.type"
        static let targetDistance = "tar.distance"
        static let targetVelocity = "tar.o.velocity"
        static let targetRelativeVelocity = "tar.o.relativeVelocity"
        
    }
}
