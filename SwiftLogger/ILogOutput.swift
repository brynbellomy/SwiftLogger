//
//  ILogOutput.swift
//  SwiftLogger
//
//  Created by bryn austin bellomy on 2014 Aug 17.
//  Copyright (c) 2014 bryn austin bellomy. All rights reserved.
//

import Foundation


/**
    Represents an output method for log message strings.
 */
public protocol ILogOutput
{
    /**
        Called by the `Logger` object to send a formatted log message string to an `ILogOutput`.
        :param: logMessageString The formatted log message string.
    */
    func write(logMessageString: String)
}


