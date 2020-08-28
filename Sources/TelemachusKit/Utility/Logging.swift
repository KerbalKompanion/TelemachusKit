////
////  File.swift
////  
////
////  Created by Noah Kamara on 27.08.20.
////
//
//import Foundation
//import os
//
//
//@available(OSX 11.0, iOS 14.0, *)
///// Logging Class
//public class Logging: LogHelper {
//    let logLevel: LoggingLevel
//    let logger: Logger
//    public func debug(_ message: String) {
//        if self.logLevel.rawValue <= LoggingLevel.debug.rawValue {
//            logger.debug("\(message)")
//        }
//    }
//    public func info(_ message: String) {
//        if self.logLevel.rawValue <= LoggingLevel.info.rawValue {
//            logger.info("\(message)")
//        }
//    }
//    public func error(_ message: String) {
//        if self.logLevel.rawValue <= LoggingLevel.error.rawValue {
//            logger.error("\(message)")
//        }
//    }
//    public func warning(_ message: String) {
//        if self.logLevel.rawValue <= LoggingLevel.warning.rawValue {
//            logger.warning("\(message)")
//        }
//    }
//    
//    required init(_ logLevel: LoggingLevel = .debug) {
//        self.logger = Logger(subsystem: "com.noahkamara.TelemachusKit", category: "KerbalKompanion")
//        self.logLevel = logLevel
//    }
//    
//    public enum Level: Int {
//        case debug = 0
//        case info = 1
//        case error = 2
//        case warning = 3
//    }
//}
