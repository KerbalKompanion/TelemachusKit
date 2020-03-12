//
//  SubscriptionManager.swift
//  
//
//  Created by Noah Kamara on 10.03.20.
//

import Foundation
import Starscream

public class TelemachusClient {
    
    /// Gets called upon establishing a connection with a server
    public var onConnect: (() -> Void)?
    /// Gets called upon disconnect
    public var onDisconnect: ((Error?) -> Void)?
    /// Gets called whenever the client receives data from Telemachus Server
    public var onTelemachusData: ((TelemachusData) -> Void)?
    
    /// The SocketDelegate
    private let socket: SocketDelegate
    
    init(_ url: URL? = nil) {
        self.socket = SocketDelegate()
        self.socket.onConnect           = self.onConnect
        self.socket.onDisconnect        = self.onDisconnect
        self.socket.onTelemachusData    = self.onTelemachusData
        
        if url != nil {
            
        }
    }
    
    /// Connect to url
    func connect(_ ip: String, _ port: Int) {
        var url: URLComponents = URLComponents()
        url.scheme = "ws"
        url.host = "192.168.178.23"
        url.path = "/datalink"
        url.port = 8085
        self.socket.connect(ip, port)
    }
    
    /// Sends command to Telemachus Server
    /// - Parameter keys: Set of ApiKeys
    func sendCommand(_ command: Command.Key, _ param: Command.Parameter) {
        let message: String = "{\"run\":[\(command)]}"
        self.socket.write(string: message)
    }
    
    /// Subscibes the Client to the given set of ApiKeys
    /// - Parameter keys: Set of ApiKeys
    func subscribeTo(_ keys: [ApiKey]) {
        let message: String = "{\"+\":\(keys)}"
        self.socket.write(string: message)
    }
    
    /// Sets the rate at which the websocket responds with data
    /// - Parameter ms: interval in miliseconds Int
    func setRate(_ ms: Int) {
        let message: String = "{\"rate\":\(ms)}"
        self.socket.write(string: message)
    }
    
}
