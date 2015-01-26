//
//  ConsoleLogOutput.swift
//  SwiftLogger
//
//  Created by bryn austin bellomy on 2015 Jan 4.
//  Copyright (c) 2014 bryn austin bellomy. All rights reserved.
//


/**
    An `ILogOutput` that writes log message strings to the console using Swift's built-in `println` function.
 */
public struct ConsoleLogOutput: ILogOutput
{
    /** The designated initializer. */
    public init() {}

    public func write (logMessageString:String) {
        println(logMessageString)
    }
}