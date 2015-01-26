//
//  ColorLogMessageFormatter.swift
//  SwiftLogger
//
//  Created by bryn austin bellomy on 2015 Jan 5.
//  Copyright (c) 2015 bryn austin bellomy. All rights reserved.
//

import Foundation
import SwiftFlatUIColors


/**
    A log message formatter that produces automatically colorized output (formatted for Xcode's console).
 */
public struct ColorLogMessageFormatter: ILogMessageFormatter
{
    /** Represents a color scheme to be used by `ColorLogMessageFormatter`. */
    public struct ColorScheme
    {
        /** The designated initializer. */
        public init() {}

        /** The foreground color for the portion of the log message containing the filename from which the log message originated. */
        var file: ColorLogging.RGB? = ColorLogging.RGB(nscolor: FlatUIColors.midnightBlueColor())

        /** The foreground color for the portion of the log message containing the line number where the log message originated. */
        var line: ColorLogging.RGB? = ColorLogging.RGB(nscolor: FlatUIColors.nephritisColor())

        /** The foreground color for the portion of the log message containing the name of the function in which the log message originated. */
        var function: ColorLogging.RGB? = ColorLogging.RGB(nscolor: FlatUIColors.turquoiseColor())

        /** The foreground color for the portion of the log message containing the actual textual log message. */
        var message: ColorLogging.RGB? = nil
    }


    /** The current color scheme. */
    public var colorScheme = ColorScheme()


    /** The designated initializer. */
    public init() {}

    /**
        Formats a log message object as a String.

        :param: logMessage The message object to format.
        :returns: The formatted log string.
     */
    public func formatLogMessage(logMessage: LogMessage) -> String
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

