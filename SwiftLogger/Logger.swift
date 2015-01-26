//
//  Logger.swift
//  SwiftLogger
//
//  Created by bryn austin bellomy on 2014 Nov 27.
//  Copyright (c) 2014 bryn austin bellomy. All rights reserved.
//

import Foundation


/**
    Accepts messages to be logged to a set of `ILogOutput` interfaces.
 */
public class Logger
{
    public var isAsync = true

    private var outputs = [(ILogOutput, ILogMessageFormatter)]()
    private var loggingQueue = dispatch_queue_create("com.illumntr.Log.loggingQueue", DISPATCH_QUEUE_SERIAL)


    public init() {
        setLoggingQueueTarget(dispatch_get_main_queue())
    }


    public func setLoggingQueueTarget(target:dispatch_queue_t) {
        dispatch_set_target_queue(loggingQueue, target)
    }


    public func addOutput (logger:ILogOutput, formatter:ILogMessageFormatter = DefaultLogMessageFormatter()) {
        outputs.append((logger, formatter))
    }


    public func log(message:LogMessage)
    {
        if isAsync
        {
            dispatch_async(loggingQueue) {
                self.sendMessageToOutputs(message)
            }
        }
        else {
            sendMessageToOutputs(message)
        }
    }


    private func sendMessageToOutputs(message:LogMessage)
    {
        for (logger, formatter) in outputs {
            let formattedMessage = formatter.formatLogMessage(message)
            logger.write(formattedMessage)
        }
    }
}



