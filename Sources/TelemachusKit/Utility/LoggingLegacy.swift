//
//  File.swift
//  
//
//  Created by Noah Kamara on 10.03.20.
//

import Foundation
import Logging


/// Legacy Logging Class
public class LoggingLegacy: LogHelper {
    let logLevel: LoggingLevel
    let logger: Logger
    public func debug(_ message: String) {
        if self.logLevel.rawValue <= LoggingLevel.debug.rawValue {
            logger.debug("\(message)")
        }
    }
    public func info(_ message: String) {
        if self.logLevel.rawValue <= LoggingLevel.info.rawValue {
            logger.info("\(message)")
        }
    }
    public func error(_ message: String) {
        if self.logLevel.rawValue <= LoggingLevel.error.rawValue {
            logger.error("\(message)")
        }
    }
    public func warning(_ message: String) {
        if self.logLevel.rawValue <= LoggingLevel.warning.rawValue {
            logger.warning("\(message)")
        }
    }
    
    required init(_ logLevel: LoggingLevel = .debug) {
        self.logger = Logger(label: "com.noahkamara.TelemachusKit")
        self.logLevel = logLevel
    }
}
