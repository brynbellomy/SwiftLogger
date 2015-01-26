//
//  JSONLogMessageFormatter.swift
//  SwiftLogger
//
//  Created by bryn austin bellomy on 2015 Jan 4.
//  Copyright (c) 2015 bryn austin bellomy. All rights reserved.
//

import Foundation


/**
    A log message formatter that outputs `LogMessage` structs as JSON objects.
 */
public struct JSONLogMessageFormatter: ILogMessageFormatter
{
    public init() {}

    /**
        Formats a log message object as a JSON string.

        :param: logMessage The message object to format.
        :returns: The JSON string.
     */
    public func formatLogMessage(logMessage: LogMessage) -> String
    {
        let message  = logMessage.msg
        let file     = logMessage.file.lastPathComponent
        let line     = "\(logMessage.line)"
        let function = logMessage.function
        let level    = logMessage.level.logLevelLabel

        var dict: [NSString: AnyObject] = [
            "file": file,
            "line": line,
            "function": function,
            "message": message,
            "level": level,
        ]

//        if let object: AnyObject = logMessage.object {
//            dict["object"] = object
//        }

        var error: NSError? = nil
        if let data = NSJSONSerialization.dataWithJSONObject(dict, options:NSJSONWritingOptions.allZeros, error:&error) {
            // @@TODO: somehow get the current dispatch queue name (the problem is capturing it at the callsite of the lllog() function so it doesn't just return the logging queue name)
            if let jsonString = NSString(data:data, encoding:NSUTF8StringEncoding) {
                return jsonString
            }
        }

        return "{\"message\": \"Could not render log message to JSON\"}"
    }

}





