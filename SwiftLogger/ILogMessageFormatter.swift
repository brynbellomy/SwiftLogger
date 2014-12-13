//
//  ILogMessageFormatter.swift
//  SwiftLogger
//
//  Created by bryn austin bellomy on 2014 Nov 27.
//  Copyright (c) 2014 bryn austin bellomy. All rights reserved.
//

import Foundation


/**
    Converts log messages into plain `String` objects which are then sent to the `ILogOutput` interfaces of a given `Logger`.
 */
public protocol ILogMessageFormatter
{
    /** The type of the log message object used by the current logging setup. */
    typealias LogMessageType

    /**
        Converts a single log message object into a `String`.
    
        :param: logMessage The log message to convert.
        :returns: A string representing the provided log message.
     */
    func formatLogMessage(logMessage: LogMessageType) -> String
}


