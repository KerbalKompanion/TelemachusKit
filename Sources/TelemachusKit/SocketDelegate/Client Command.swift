//
//  File.swift
//  
//
//  Created by Noah Kamara on 10.03.20.
//

import Foundation

extension TelemachusClient {
    
    /// Class for building commands
    public class Command {
        /// Api Keys for commands
        public enum Key: String {
            /// Set Throttle Param: Float
            case throttle      = "f.setThrottle"
            
            /// Set Increase Throttle
            case throttleUp    = "f.throttleUp"
            
            /// Set Decrease Throttle
            case throttleDown  = "f.throttleDown"
            
            /// Set throttle to max
            case throttleFull  = "f.throttleFull"
            
            /// Set throttle to zero
            case throttleZero  = "f.throttleZero"
            
            
            /// Set RCS Params: None (toggle), on, off
            case rcs           = "f.rcs"
            /// Set SAS Params: None (toggle), on, off
            case sas           = "f.sas"
            
            
            /// Set Light Params: None (toggle), on, off
            case light         = "f.light"
            
            /// Set Light Params: None (toggle), on, off
            case gear          = "f.gear"
            
            /// Set Light Params: None (toggle), on, off
            case brake         = "f.brake"
            
            /// Toggle abort
            case abort         = "f.abort"
            
            /// Toggle ActionGroup 01
            case actionGroup01 = "f.ag1"
            
            /// Toggle ActionGroup 02
            case actionGroup02 = "f.ag2"
            
            /// Toggle ActionGroup 03
            case actionGroup03 = "f.ag3"
            
            /// Toggle ActionGroup 04
            case actionGroup04 = "f.ag4"
            
            /// Toggle ActionGroup 05
            case actionGroup05 = "f.ag5"
            
            /// Toggle ActionGroup 06
            case actionGroup06 = "f.ag6"
            
            /// Toggle ActionGroup 07
            case actionGroup07 = "f.ag7"
            
            /// Toggle ActionGroup 08
            case actionGroup08 = "f.ag8"
            
            /// Toggle ActionGroup 09
            case actionGroup09 = "f.ag9"
            
            /// Toggle ActionGroup 10
            case actionGroup10 = "f.ag10"
        }
        
        
        /// A parameter that can be added to a command Key
        public enum Parameter: String {
            /// on
            case on   = "true"
            /// off
            case off  = "false"
        }
    }
}
