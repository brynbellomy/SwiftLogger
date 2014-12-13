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
public class Logger<F : ILogMessageFormatter>
{
    public typealias Message = F.LogMessageType
    public typealias Formatter = F

    public var isAsync = true
    public var formatter : Formatter

    var outputs = [ILogOutput]()
    var loggingQueue = dispatch_queue_create("com.illumntr.Log.loggingQueue", DISPATCH_QUEUE_SERIAL)


    public init(formatter f:Formatter)
    {
        formatter = f
        setLoggingQueueTarget(dispatch_get_main_queue())
    }


    public func setLoggingQueueTarget(target:dispatch_queue_t) {
        dispatch_set_target_queue(loggingQueue, target)
    }

    public func addOutput(logger:ILogOutput) {
        outputs.append(logger)
    }


    public func log(message:Message)
    {
        let formattedMessage = formatter.formatLogMessage(message)

        if isAsync
        {
            dispatch_async(loggingQueue) {
                self.sendMessageToOutputs(formattedMessage)
            }
        }
        else {
            sendMessageToOutputs(formattedMessage)
        }
    }


    private func sendMessageToOutputs(message:String)
    {
        for logger in outputs {
            logger.write(message)
        }
    }
}



