//
//  File.swift
//  
//
//  Created by Noah Kamara on 10.03.20.
//

import Foundation

extension TelemachusClient {
    public class Command {
        public enum Key: String {
            case throttle      = "f.setThrottle"
            case throttleUp    = "f.throttleUp"
            case throttleDown  = "f.throttleDown"
            case throttleFull  = "f.throttleFull"
            case throttleZero  = "f.throttleZero"
            
            case rcs           = "f.rcs"
            case sas           = "f.sas"
            
            case light         = "f.light"
            case gear          = "f.gear"
            case brake         = "f.brake"
            
            case abort         = "f.abort"
            
            case actionGroup01 = "f.ag1"
            case actionGroup02 = "f.ag2"
            case actionGroup03 = "f.ag3"
            case actionGroup04 = "f.ag4"
            case actionGroup05 = "f.ag5"
            case actionGroup06 = "f.ag6"
            case actionGroup07 = "f.ag7"
            case actionGroup08 = "f.ag8"
            case actionGroup09 = "f.ag9"
            case actionGroup10 = "f.ag10"
        }
        
        public enum Parameter {
            static let on   = "true"
            static let off  = "true"
        }
    }
}
