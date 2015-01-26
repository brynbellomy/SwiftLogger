//
//  DefaultLogMessageFormatter.swift
//  SwiftLogger
//
//  Created by bryn austin bellomy on 2015 Jan 5.
//  Copyright (c) 2015 bryn austin bellomy. All rights reserved.
//

import Foundation


/**
    An example/default log message formatter.  Converts message objects into strings of the format: `[file:line] functionName (log level) message...`
 */
public struct DefaultLogMessageFormatter: ILogMessageFormatter
{
    public init() {}

    /**
        Formats a log message object as a String.

        :param: logMessage The message object to format.
        :returns: The formatted log string.
     */
    public func formatLogMessage(logMessage: LogMessage) -> String
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



