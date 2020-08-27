//
//  SubscriptionManager.swift
//  
//
//  Created by Noah Kamara on 10.03.20.
//

import Foundation
import Starscream

/// The Client or communicating with the Telemachus Websocket
public class TelemachusClient: ObservableObject {
    private let logLevel: LoggingLevel
    /// Gets called upon establishing a connection with a server
    public var onConnect: (() -> Void)?
    /// Gets called upon disconnect
    public var onDisconnect: ((Error?) -> Void)?
    /// Gets called whenever the client receives data from Telemachus Server
    public var onTelemachusData: ((TelemachusData) -> Void)?
    
    /// The SocketDelegate
    private let socket: SocketDelegate
    
    /// The last data the server sent
    @Published public var data: TelemachusData = TelemachusData()
    
    /// Indicates whether the client is connected to a Telemachus server
    @Published public var isConnected: Bool = false
    
    /// The Current URL of the Server
    @Published public var currentURL: URL? = nil
    
    
    /// Initializes the Client
    public init(_ logLevel: LoggingLevel = .error) {
        self.logLevel = logLevel
        self.socket = SocketDelegate(self.logLevel)
        self.socket.onConnect = {
            self.isConnected = true
            self.onConnect?()
            self.currentURL = self.socket.currentUrl
        }
        self.socket.onDisconnect = { (error: Error?) in
            self.isConnected = false
            self.onDisconnect?(error)
        }
        self.socket.onTelemachusData = { (data: TelemachusData) in
            self.data = data
            self.onTelemachusData?(data)
        }
    }
    
    /// Connect to url
    public func connect(_ ip: String, _ port: Int) {
        var url: URLComponents = URLComponents()
        url.scheme = "ws"
        url.host = ip
        url.path = "/datalink"
        url.port = port
        if url.url != nil {
            // TODO: Throw error here
        }
        self.socket.connect(ip, port)
    }
    
    /// Connect to url with Completion
    public func connect(_ ip: String, _ port: Int, completion: Completion.Basic) {
        var url: URLComponents = URLComponents()
        url.scheme = "ws"
        url.host = ip
        url.path = "/datalink"
        url.port = port
        if url.url != nil {
            // TODO: Throw error here
        }
        self.socket.connect(ip, port) { result in
            switch result {
                case .success: completion(.success(true))
                case .failure(let error): completion(.failure(error))
            }
        }
    }
    
    /// Disconnects from Server
    public func disconnect() {
        self.socket.disconnect()
    }
    
    /// Sends command to Telemachus Server
    /// - Parameter keys: Set of ApiKeys
    public func sendCommand(_ command: Command.Key, _ param: Command.Parameter? = nil) {
        var message = ""
        if param == nil {
            message = "{\"run\":[\"\(command.rawValue)\"]}"
        } else {
            message = "{\"run\":[\"\(command.rawValue)\"]}"
        }
        self.socket.write(string: message)
        
    }
    
    /// Subscibes the Client to the given set of ApiKeys
    /// - Parameter keys: Set of ApiKeys
    public func subscribeTo(_ keys: [ApiKey]) {
        let message: String = "{\"+\":\(keys.map({$0.rawValue}))}"
        self.socket.write(string: message)
    }
    
    /// Sets the rate at which the websocket responds with data
    /// - Parameter ms: interval in miliseconds Int
    public func setRate(_ ms: Int) {
        let message: String = "{\"rate\":\(ms)}"
        self.socket.write(string: message)
    }
    
}
