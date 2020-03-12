//
//  File.swift
//  
//
//  Created by Noah Kamara on 10.03.20.
//

import Foundation

class Logger {
    static func log(_ level: Log.Level, _ origin: String, _ message: String) {
        let log = Log(origin: origin, level: level, message: message)
        let message = "\(log.levelIcon()) : \(log.origin) :\t \(log.message)"
        print(message)
    }
    
    struct Log {
        let origin: String
        let level: Level
        let message: String
        enum Level {
            case debug
            case info
            case error
            case warning
        }
        func levelIcon() -> String {
            switch level {
                case .debug : return "🐞"
                case .info : return "ℹ️"
                case .error : return "🚨"
                case .warning : return "⚠️"
            }
        }
    }
    
    //DEBUG,INFO,ERROR,EXCEPTION,WARNING
}
