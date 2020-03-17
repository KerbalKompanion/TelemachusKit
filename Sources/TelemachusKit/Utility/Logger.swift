//
//  File.swift
//  
//
//  Created by Noah Kamara on 10.03.20.
//

import Foundation
import Logging

public class LogHelper {
    let logLevel: Level
    let logger: Logger
    public func debug(_ message: String) {
        if self.logLevel.rawValue <= Level.debug.rawValue {
            logger.debug("\(message)")
        }
    }
    public func info(_ message: String) {
        if self.logLevel.rawValue <= Level.info.rawValue {
            logger.info("\(message)")
        }
    }
    public func error(_ message: String) {
        if self.logLevel.rawValue <= Level.error.rawValue {
            logger.error("\(message)")
        }
    }
    public func warning(_ message: String) {
        if self.logLevel.rawValue <= Level.warning.rawValue {
            logger.warning("\(message)")
        }
    }
    
    init(label: String, _ logLevel: Level = .debug) {
        self.logger = Logger(label: label)
        self.logLevel = logLevel
    }
    
    public enum Level: Int {
        case debug = 0
        case info = 1
        case error = 2
        case warning = 3
    }
}
