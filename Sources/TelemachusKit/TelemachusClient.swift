//
//  SubscriptionManager.swift
//  
//
//  Created by Noah Kamara on 10.03.20.
//

import Foundation
import Starscream

public class TelemachusClient: ObservableObject {
    
    /// Gets called upon establishing a connection with a server
    public var onConnect: (() -> Void)?
    /// Gets called upon disconnect
    public var onDisconnect: ((Error?) -> Void)?
    /// Gets called whenever the client receives data from Telemachus Server
    public var onTelemachusData: ((TelemachusData) -> Void)?
    
    /// The SocketDelegate
    private let socket: SocketDelegate
    
    @Published public var data: TelemachusData = TelemachusData()
    @Published public var isConnected: Bool = false
    @Published public var currentURL: URL? = nil
    
    public init() {
        self.socket = SocketDelegate()
        self.socket.onConnect = {
            DispatchQueue.main.async
            {
                self.isConnected = false
                    
            }
            self.isConnected = true
            self.onConnect?()
        }
        self.socket.onDisconnect = { (error: Error?) in
            DispatchQueue.main.async {
                self.isConnected = false
            }
            self.onDisconnect?(error)
        }
        self.socket.onTelemachusData = { (data: TelemachusData) in
            DispatchQueue.main.async {
                self.data = data
            }
            self.onTelemachusData?(data)
        }
    }
    
    /// Connect to url
    public func connect(_ ip: String, _ port: Int) {
        var url: URLComponents = URLComponents()
        url.scheme = "ws"
        url.host = "192.168.178.23"
        url.path = "/datalink"
        url.port = 8085
        self.socket.connect(ip, port)
    }
    
    /// Sends command to Telemachus Server
    /// - Parameter keys: Set of ApiKeys
    public func sendCommand(_ command: Command.Key, _ param: Command.Parameter) {
        let message: String = "{\"run\":[\(command)]}"
        self.socket.write(string: message)
    }
    
    /// Subscibes the Client to the given set of ApiKeys
    /// - Parameter keys: Set of ApiKeys
    public func subscribeTo(_ keys: [ApiKey]) {
        let message: String = "{\"+\":\(keys)}"
        self.socket.write(string: message)
    }
    
    /// Sets the rate at which the websocket responds with data
    /// - Parameter ms: interval in miliseconds Int
    public func setRate(_ ms: Int) {
        let message: String = "{\"rate\":\(ms)}"
        self.socket.write(string: message)
    }
    
}
