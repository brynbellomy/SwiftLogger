//
//  SwiftLogger.swift
//  SwiftLogger
//
//  Created by bryn austin bellomy on 2014 Jul 4.
//  Copyright (c) 2014 bryn austin bellomy. All rights reserved.
//

import Foundation


/**
    A singleton-ish object containing a few convenience functions.
 */
public struct SwiftLogger
{
    /** A `Logger` object initialized with the default built-in logging setup (`ColorLogMessageFormatter`, etc.). */
    public static var defaultLogger = Logger()

//    * Convenience function for logging configurations that don't need much customizing beyond what's offered by `ColorLogMessageFormatter`. 
//    public static func logToDefaultLogger(level:IColorizableLogLevel, msg:String, file:String = __FILE__, function:String = __FUNCTION__, line:Int = __LINE__, column:Int = __COLUMN__)
//    {
//        let message = LogMessage(type:.String, level:level, msg:msg, object:nil, file:file, function:function, line:line, column:column)
//        defaultLogger.log(message)
//    }
//
//    /** Convenience function for logging configurations that don't need much customizing beyond what's offered by `ColorLogMessageFormatter`. */
//    public static func logDictionaryToDefaultLogger <K: Printable, V: Printable> (level:IColorizableLogLevel, prefix:String, dictionary:[K: V], file:String = __FILE__, function:String = __FUNCTION__, line:Int = __LINE__, column:Int = __COLUMN__)
//    {
//        let message = LogMessage(type:.Dictionary, level:level, msg:prefix, object:dictionary, file:file, function:function, line:line, column:column)
//        defaultLogger.log(message)
//    }
}










