//
//  File.swift
//  
//
//  Created by Noah Kamara on 10.03.20.
//

import Foundation

extension TelemachusClient {
    public class Command {
        public enum Key {
            static let throttle      = "f.setThrottle"
            static let throttleUp    = "f.throttleUp"
            static let throttleDown  = "f.throttleDown"
            static let throttleFull  = "f.throttleFull"
            static let throttleZero  = "f.throttleZero"
            
            static let rcs           = "f.rcs"
            static let sas           = "f.sas"
            
            static let light         = "f.light"
            static let gear          = "f.gear"
            static let brake         = "f.brake"
            
            static let abort         = "f.abort"
            
            static let actionGroup01 = "f.ag1"
            static let actionGroup02 = "f.ag2"
            static let actionGroup03 = "f.ag3"
            static let actionGroup04 = "f.ag4"
            static let actionGroup05 = "f.ag5"
            static let actionGroup06 = "f.ag6"
            static let actionGroup07 = "f.ag7"
            static let actionGroup08 = "f.ag8"
            static let actionGroup09 = "f.ag9"
            static let actionGroup10 = "f.ag10"
        }
        
        public enum Parameter {
            static let on   = "true"
            static let off  = "true"
        }
    }
}
