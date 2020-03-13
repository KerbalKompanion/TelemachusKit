//
//  File.swift
//  
//
//  Created by Noah Kamara on 12.03.20.
//

import Foundation
import Starscream
class SocketDelegate: WebSocketDelegate, WebSocketPongDelegate {
    /// The reference to the Websocket
    private var websocket: WebSocket!
    
    /// The URL the Websocket connects to
    private var url = URLComponents()
    
    
    /// Logs the Message with the according log level
    /// - Parameters:
    ///   - level: Log-Level
    ///   - message: String message
    private func log(_ level: Logger.Log.Level, _ message: String) {
        Logger.log(level, "SocketDelegate", message)
    }
    
    /// Gets called upon establishing a connection with a server
    public var onConnect: (() -> Void)?
    /// Gets called upon disconnect
    public var onDisconnect: ((Error?) -> Void)?
    /// Gets called whenever the client receives data from Telemachus Server
    public var onTelemachusData: ((TelemachusData) -> Void)?
    
    
    /// The current URL. will be nil if not connected
    public var currentUrl: URL? = nil
    
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
    
    
    /// Disconnect from Server
    func disconnect() {
        if websocket.isConnected {
            websocket.disconnect()
        }
    }
    
    /// Sends the String to the Server
    /// - Parameter string: The String to be sent
    func write(string: String) {
        self.log(.info, "sent message")
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
                let json = try JSONDecoder().decode(JsonModel.self, from: data)
                self.onTelemachusData?(TelemachusData(json))
            } catch let error {
                self.log(.error, "\(error)")
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
