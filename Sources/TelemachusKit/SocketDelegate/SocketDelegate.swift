//
//  File.swift
//  
//
//  Created by Noah Kamara on 12.03.20.
//

import Foundation
import Starscream
class SocketDelegate: WebSocketDelegate, WebSocketPongDelegate {
    
    /// LogLevel
    private let logger: LogHelper
    
    /// The reference to the Websocket
    private var websocket: WebSocket!
    
    /// The URL the Websocket connects to
    private var url = URLComponents()
    
    
    /// Logs the Message with the according log level
    /// - Parameters:
    ///   - level: Log-Level
    ///   - message: String message
    private func log(_ level: LogHelper.Level, _ message: String) {
        switch level {
            case .debug: self.logger.debug(message)
            case .info: self.logger.info(message)
            case .error: self.logger.error(message)
            case .warning: self.logger.warning(message)
        }
    }
    
    /// Gets called upon establishing a connection with a server
    public var onConnect: (() -> Void)?
    /// Gets called upon disconnect
    public var onDisconnect: ((Error?) -> Void)?
    /// Gets called whenever the client receives data from Telemachus Server
    public var onTelemachusData: ((TelemachusData) -> Void)?
    
    
    /// The current URL. will be nil if not connected
    public var currentUrl: URL? = nil
    
    init(_ loglevel: LogHelper.Level) {
        self.logger     = LogHelper(label: "com.TelemachusKit.SocketDelegate", loglevel)
    }
    
    /// Connect to url
    func connect(_ ip: String, _ port: Int) {
        self.url.scheme = "ws"
        self.url.host = "192.168.178.23"
        self.url.path = "/datalink"
        self.url.port = 8085
        
        self.websocket = WebSocket(url: self.url.url!)
        websocket.delegate = self
        websocket.disableSSLCertValidation = true
        websocket.enableCompression = false
        
        self.log(.info, "connecting to \(url.url!)")
        websocket.connect()
    }
    
    /// Connect to url with Completion
    func connect(_ ip: String, _ port: Int, completion: Completion.Basic ) {
        self.url.scheme = "ws"
        self.url.host = "192.168.178.23"
        self.url.path = "/datalink"
        self.url.port = 8085
        
        self.websocket = WebSocket(url: self.url.url!)
        websocket.delegate = self
        websocket.disableSSLCertValidation = true
        websocket.enableCompression = false
        
        self.log(.info, "connecting to \(url.url!)")
        websocket.connect()
        var startDate = Date()
        startDate.addTimeInterval(10)
        do {
            while true {
                if Date() > startDate {
                    throw TelemachusErrors.ConnectionError.refused
                }
                if websocket.isConnected {
                    completion(.success(true))
                    break
                }
            }
        } catch let error {
            completion(.failure(error))
        }
    }
    
    
    /// Disconnect from Server
    func disconnect() {
        if websocket.isConnected {
            websocket.disconnect()
        }
    }
    
    /// Sends the String to the Server
    /// - Parameter string: The String to be sent
    func write(string: String) {
        self.websocket.write(string: string)
        self.log(.info, "Sent message (String)")
        self.log(.debug, "Sent message (String): \(string)")
        self.onConnect?()
    }
        
    /// Called when Websocket did connect
    /// - Parameter socket: Websocket
    internal func websocketDidConnect(socket: WebSocketClient) {
        self.log(.info, "connected to \(websocket.currentURL)")
        self.currentUrl = websocket.currentURL
        self.onConnect?()
    }
    
    /// Called when Websocket did disconnect
    /// - Parameters:
    ///   - socket: Websocket
    ///   - error: (optional) error that caused the disconnect
    internal func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        if error != nil {
            self.log(.info, "disconnected from \(url.url!) ERROR: \(error?.localizedDescription ?? "No Error")")
        } else {
            self.log(.info, "disconnected from \(url.url!)")
        }
        self.log(.debug, "disconnected URL: \(url.url!) ERROR: \(error?.localizedDescription ?? "NO ERROR")")
        self.currentUrl = nil
        self.onDisconnect?(error)
    }
    
    /// Called when Websocket received String
    /// - Parameters:
    ///   - socket: Websocket
    ///   - text: String  that was received
    internal func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        self.log(.info, "message received (String)")
        self.log(.debug, "message received (String) URL: \(url.url!) STRING: \(text)")
        if text == "{}" {
            
        }
        
        if let data = text.data(using: .utf8) {
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let gameStatus = json["p.paused"] as? Int {
                        self.log(.info, "GAME STATUS: \(TelemachusData.GameStatus.init(rawValue: gameStatus) ?? .error)")
                    }
                }
                let json_model = try JSONDecoder().decode(JsonModel.self, from: data)
                self.onTelemachusData?(TelemachusData(json_model))
            } catch let error {
                self.log(.error, "\(error)")
                let tData = TelemachusData()
                tData.gameStatus = .error
                self.onTelemachusData?(tData)
            }
        }
        
    }
    
    /// Called when Websocket received Data
    /// - Parameters:
    ///   - socket: Websocket
    ///   - data: Data that was received
    internal func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        self.log(.info, "message received (Data)")
        self.log(.debug, "message received (DATA) URL: \(url.url!) DATA: \(data)")
    }
    
    /// Called when Websocket received Pong
    /// - Parameters:
    ///   - socket: Websocket
    ///   - data: Data that was received
    internal func websocketDidReceivePong(socket: WebSocketClient, data: Data?) {
        self.log(.info, "message received (Pong)")
        self.log(.debug, "message received (Pong) URL: \(url.url!) DATA: \(data?.count ?? 0)")
    }
}
