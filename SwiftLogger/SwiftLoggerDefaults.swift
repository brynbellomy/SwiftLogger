//
//  SwiftLoggerDefaults.swift
//  SwiftLogger
//
//  Created by bryn austin bellomy on 2014 Nov 26.
//  Copyright (c) 2014 bryn austin bellomy. All rights reserved.
//

import Foundation
import FlatUIColors



/**
    Example/default global namespace log function.
*/
public func lllog(level:DefaultLogLevel, msg:String, file:String = __FILE__, function:String = __FUNCTION__, line:Int = __LINE__, column:Int = __COLUMN__)
{
    SwiftLogger.logDefaultMessageToDefaultLogger(level, msg:msg, file:file, function:function, line:line, column:column)
}


/**
    Example/default global namespace log function for conveniently dumping variable contents.  Uses the built-in `dump()` function to produce its output.
*/
public func lllog_dump<T>(level:DefaultLogLevel, value:T, _ prefix:String? = nil, file:String = __FILE__, function:String = __FUNCTION__, line:Int = __LINE__, column:Int = __COLUMN__)
{
    var msg = ""
    dump(value, &msg)

    if let prefix = prefix? {
        msg = "\(prefix) \(msg)"
    }

    SwiftLogger.logDefaultMessageToDefaultLogger(level, msg:msg, file:file, function:function, line:line, column:column)
}


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



public protocol IDefaultLogMessage
{
    var level: IColorizableLogLevel { get }
    var msg: String { get }
    var file: String { get }
    var function: String { get }
    var line: Int { get }
    var column: Int { get }
}



//
// MARK: - Log message type -
//

/**
    An example log message object.  `DefaultLogMessage` is included both for demonstrative purposes as well as because it is a fully-realized
    `IDefaultLogMessage` type that can be used by your application.
*/
public struct DefaultLogMessage : IDefaultLogMessage
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
    /** Log messages related to debugging. */
    case Debug = "debug"

    /** Log messages with important errors. */
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


//
// MARK: - Log message formatters
//

public protocol IDefaultLogMessageFormatter : ILogMessageFormatter
{
    func formatLogMessage(logMessage: IDefaultLogMessage) -> String
}

/**
    An example/default log message formatter.  Converts message objects into strings of the format: `[file:line] functionName (log level) message...`
 */
public class DefaultLogMessageFormatter : IDefaultLogMessageFormatter
{
    public init() {}

    /**
        Formats a log message object as a String.

        :param: logMessage The message object to format.
        :returns: The formatted log string.
     */
    public func formatLogMessage(logMessage: IDefaultLogMessage) -> String
    {
        let file     = logMessage.file.lastPathComponent
        let line     = "\(logMessage.line)"
        let function = logMessage.function
        let message  = logMessage.msg
        let logLevel = logMessage.level.logLevelLabel

        // @@TODO: somehow get the current dispatch queue name (the problem is capturing it at the callsite of the lllog() function so it doesn't just return the logging queue name)
        return "[\(file):\(line)] \(function) (\(logLevel)) \(message)"
    }

}



/**
    A log message formatter that produces automatically colorized output (formatted for Xcode's console).
 */
public class ColorLogMessageFormatter : DefaultLogMessageFormatter, ILogMessageFormatter
{
    /** Represents a color scheme to be used by `ColorLogMessageFormatter`. */
    public struct ColorScheme {
        /** The designated initializer. */
        public init() {}

        /** The foreground color for the portion of the log message containing the filename from which the log message originated. */
        var file     : ColorLogging.RGB? = ColorLogging.RGB(nscolor: FlatUIColors.midnightBlueColor())

        /** The foreground color for the portion of the log message containing the line number where the log message originated. */
        var line     : ColorLogging.RGB? = ColorLogging.RGB(nscolor: FlatUIColors.nephritisColor())

        /** The foreground color for the portion of the log message containing the name of the function in which the log message originated. */
        var function : ColorLogging.RGB? = ColorLogging.RGB(nscolor: FlatUIColors.turquoiseColor())

        /** The foreground color for the portion of the log message containing the actual textual log message. */
        var message  : ColorLogging.RGB? = nil
    }

    /** The current color scheme. */
    public var colorScheme = ColorScheme()

    /**
        Formats a log message object as a String.

        :param: logMessage The message object to format.
        :returns: The formatted log string.
     */
    override public func formatLogMessage(logMessage: IDefaultLogMessage) -> String
    {
        let file     = (colorScheme.file == nil) ? logMessage.file.lastPathComponent : ColorLogging.Colorize.Foreground(colorScheme.file!, text:logMessage.file.lastPathComponent)
        let line     = (colorScheme.line == nil) ? "\(logMessage.line)" : ColorLogging.Colorize.Foreground(colorScheme.line!, text:"\(logMessage.line)")
        let function = (colorScheme.function == nil) ? logMessage.function : ColorLogging.Colorize.Foreground(colorScheme.function!, text:logMessage.function)
        let message  = (colorScheme.message == nil) ? logMessage.msg : ColorLogging.Colorize.Foreground(colorScheme.message!, text:logMessage.msg)

        let logLevel = logMessage.level.colorizedLogLevelLabel

        // @@TODO: somehow get the current dispatch queue name (the problem is capturing it at the callsite of the lllog() function so it doesn't just return the logging queue name)
        return "[\(file):\(line)] \(function) (\(logLevel)) \(message)"
    }

}





