//
//  File.swift
//  
//
//  Created by Noah Kamara on 10.03.20.
//

import Foundation

class Logger {
    static let loglevel: Log.Level = .error
    static func log(_ level: Log.Level, _ origin: String, _ message: String) {
        if level.rawValue >= self.loglevel.rawValue {
            let log = Log(origin: origin, level: level, message: message)
            let message = "\(log.levelIcon()) : \(log.origin) :\t \(log.message)"
            print(message)
        }
    }
    
    struct Log {
        let origin: String
        let level: Level
        let message: String
        enum Level: Int {
            case debug = 0
            case info = 1
            case error = 2
            case warning = 3
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
