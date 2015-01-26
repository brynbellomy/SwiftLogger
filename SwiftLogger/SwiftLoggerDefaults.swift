//
//  SwiftLoggerDefaults.swift
//  SwiftLogger
//
//  Created by bryn austin bellomy on 2014 Nov 26.
//  Copyright (c) 2014 bryn austin bellomy. All rights reserved.
//

import Foundation
import SwiftFlatUIColors



/**
    Represents the log level scheme used by the current logging setup.  A log message's level generally specifies the severity or importance of the message.
 */
public protocol ILogLevel
{
    /** The text label used to denote a given log level. */
    var logLevelLabel : String { get }
}



public protocol IColorizableLogLevel : ILogLevel {
    var colorizedLogLevelLabel : String { get }
}



//
// MARK: - Log message type -
//

/**
    Represents a log message.
*/
public struct LogMessage
{
    public var level: IColorizableLogLevel
    public var msg: String

    public var file: String
    public var function: String
    public var line: Int
    public var column: Int
}

//
// MARK: - Log level schemas
//

// MARK: enum DefaultLogLevel

/**
    An example log level schema.
 */
public enum DefaultLogLevel : String, ILogLevel, IColorizableLogLevel
{
    case Debug = "debug"
    case Error = "error"
    case Warning = "warning"
    case Info = "info"
    case Verbose = "verbose"
    case Success = "success"

    public var logLevelLabel : String {
        return rawValue
    }

    public var colorizedLogLevelLabel : String {
        switch self {
            case .Debug:    return ColorLogging.Colorize.Purple(logLevelLabel)
            case .Error:    return ColorLogging.Colorize.Red(logLevelLabel)
            case .Warning:  return ColorLogging.Colorize.Orange(logLevelLabel)
            case .Info:     return ColorLogging.Colorize.White(logLevelLabel)
            case .Verbose:  return ColorLogging.Colorize.Blue(logLevelLabel)
            case .Success:  return ColorLogging.Colorize.Green(logLevelLabel)
        }
    }

}








