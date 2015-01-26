//
//  WebsocketOutput.swift
//  SwiftLogger
//
//  Created by bryn austin bellomy on 2015 Jan 4.
//  Copyright (c) 2014 bryn austin bellomy. All rights reserved.
//

import Starscream


/**
    An `ILogOutput` that writes log message strings to a websocket.
 */
public class WebsocketLogOutput: ILogOutput
{
    public enum State {
        case Disconnected, Connected, Error
    }

    public let host: String
    public let path: String
    public private(set) var state: State = .Disconnected

    private var socket: WebSocket?


    public init?(host h:String = "localhost:8080", path p:String = "/")
    {
        host = h
        path = p

        if let url = NSURL(scheme:"ws", host:host, path:path) {
            socket = WebSocket(url: url)
            socket!.delegate = self
        }
        else {
            return nil
        }
    }

    public func write(logMessageString: String) {
        socket?.writeString(logMessageString)
    }

    public func connect() {
        if !socket!.isConnected {
            socket?.connect()
        }
    }

    public func disconnect() {
        if socket!.isConnected {
            socket?.disconnect()
        }
    }
}


//
// MARK: - WebsocketOutput: WebSocketDelegate -
//

extension WebsocketLogOutput: WebSocketDelegate {

    public func websocketDidConnect() {
        println("websocket is connected")
        state = .Connected
    }

    public func websocketDidDisconnect(error: NSError?) {
        state = .Disconnected
        if let e = error {
            println("websocket is disconnected: \(e.localizedDescription)")
        }
    }

    public func websocketDidWriteError(error: NSError?) {
        state = .Error
        if let e = error {
            println("wez got an error from the websocket: \(e.localizedDescription)")
        }
    }

    public func websocketDidReceiveMessage(text: String) {
        println("Received text: \(text)")
    }

    public func websocketDidReceiveData(data: NSData) {
        println("Received data: \(data.length)")
    }
}



