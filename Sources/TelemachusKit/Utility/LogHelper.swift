//
//  File.swift
//  
//
//  Created by Noah Kamara on 27.08.20.
//

import Foundation


/// Protocol for Loggers
protocol LogHelper {
    func debug(_ message: String)
    func info(_ message: String)
    func error(_ message: String)
    func warning(_ message: String)
    
    init(_ logLevel: LoggingLevel)
}


/// LoggingLevel
public enum LoggingLevel: Int {
    case debug = 0
    case info = 1
    case error = 2
    case warning = 3
}
