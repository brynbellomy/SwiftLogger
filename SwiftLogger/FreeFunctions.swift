//
//  FreeFunctions.swift
//  SwiftLogger
//
//  Created by bryn austin bellomy on 2015 Jan 5.
//  Copyright (c) 2015 bryn austin bellomy. All rights reserved.
//

import Foundation
import LlamaKit
import Funky



//
// MARK: Log functions for non-functional contexts
//

public func lllog (level:DefaultLogLevel, msg:String, file:String = __FILE__, function:String = __FUNCTION__, line:Int = __LINE__, column:Int = __COLUMN__)
{
    let message = LogMessage(level:level, msg:msg, file:file, function:function, line:line, column:column)
    SwiftLogger.defaultLogger.log(message)
}


public func lllog <T: Printable> (level:DefaultLogLevel, object:[T], prefix:String = "", file:String = __FILE__, function:String = __FUNCTION__, line:Int = __LINE__, column:Int = __COLUMN__)
{
    let text = "\(prefix) \(describe(object))"

    let message = LogMessage(level:level, msg:text, file:file, function:function, line:line, column:column)
    SwiftLogger.defaultLogger.log(message)
}

public func lllog <K: Printable, V: Printable> (level:DefaultLogLevel, object:[K: V], prefix:String = "", file:String = __FILE__, function:String = __FUNCTION__, line:Int = __LINE__, column:Int = __COLUMN__)
{
    let text = "\(prefix) \(describe(object))"

    let message = LogMessage(level:level, msg:text, file:file, function:function, line:line, column:column)
    SwiftLogger.defaultLogger.log(message)
}



//
// MARK: Curried log functions for functional contexts
//

public func lllog <T> (level:DefaultLogLevel, closure:T -> String, file:String = __FILE__, function:String = __FUNCTION__, line:Int = __LINE__, column:Int = __COLUMN__)(val:T)
{
    let text = closure(val)

    let message = LogMessage(level:level, msg:text, file:file, function:function, line:line, column:column)
    SwiftLogger.defaultLogger.log(message)
}

public func lllog <T> (level:DefaultLogLevel, #prefix:String, file:String = __FILE__, function:String = __FUNCTION__, line:Int = __LINE__, column:Int = __COLUMN__)(val:T)
{
    let text = "\(prefix) \(val)"

    let message = LogMessage(level:level, msg:text, file:file, function:function, line:line, column:column)
    SwiftLogger.defaultLogger.log(message)
}


public func logFailure <T> (result:Result<T>, _ level:DefaultLogLevel = .Error, _ prefix:String = "", file:String = __FILE__, function:String = __FUNCTION__, line:Int = __LINE__, column:Int = __COLUMN__)
{
    if let error = result.error() {
        lllog(.Error, "[failure] \(error.localizedDescription)")
    }
}


public func logFailure <T> (level:DefaultLogLevel, #prefix:String, file:String = __FILE__, function:String = __FUNCTION__, line:Int = __LINE__, column:Int = __COLUMN__) (result:Result<T>)
{
    if let error = result.error() {
        lllog(.Error, "[failure] \(error.localizedDescription)")
    }
}


/**
    Example/default global namespace log function for conveniently dumping variable contents.  Uses the built-in `dump()` function to produce its output.
*/
public func lllog_dump<T>(level:DefaultLogLevel, value:T, _ prefix:String? = nil, file:String = __FILE__, function:String = __FUNCTION__, line:Int = __LINE__, column:Int = __COLUMN__)
{
    var text = ""
    dump(value, &text)

    if let prefix = prefix {
        text = "\(prefix) \(text)"
    }

    let message = LogMessage(level:level, msg:text, file:file, function:function, line:line, column:column)
    SwiftLogger.defaultLogger.log(message)
}



public func describeColor (dict:[String: AnyObject]) -> String
{
   let keysAsStrings = Array(dict.keys)
   let maxLength = keysAsStrings |> mapr { $0.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) } |> maxElement

    func formatKeyValue(key: String, value: AnyObject) -> String {
        let keyColorized = "\(key):"
            |> pad‡ (maxLength + 2)
            |> ColorLogging.Colorize.Blue

        let valColorized = "\(value.description)"
            |> ColorLogging.Colorize.Grey

        return indent(keyColorized + valColorized)
    }

   return dict |> map‡ (formatKeyValue)
               |> joinWith(",\n")
               |> { "{\n\($0)\n}" }
}






