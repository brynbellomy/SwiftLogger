//
//  FileLogOutput.swift
//  SwiftLogger
//
//  Created by bryn austin bellomy on 2015 Jan 4.
//  Copyright (c) 2014 bryn austin bellomy. All rights reserved.
//

/**
    An `ILogOutput` that writes log message strings to a file using `NSString`'s `writeToFile:atomically:encoding:error:` method.
 */
public struct FileLogOutput : ILogOutput
{
    /** The path to the log file. */
    public let logfilePath : String

    /**
        The designated initializer.

        :param: logFilePath The path to the log file that the logger should use.
        :param: truncateFileOnInit If `true`, any existing data in the log file will be truncated (erased) when `FileLogOutput` initializes.
    */
    public init(logfilePath p: String, truncateFileOnInit:Bool = false)
    {
        logfilePath = p

        if truncateFileOnInit {
            truncateLogFile()
        }
    }


    public func write(logMessageString: String)
    {
        var error : NSError?

        let currentContents = NSString(contentsOfFile:logfilePath, encoding:NSUTF8StringEncoding, error:&error)
        let updatedContents = "\(currentContents)\n\(logMessageString)"

        let success = updatedContents.writeToFile(logfilePath, atomically:true, encoding:NSUTF8StringEncoding, error:&error)

        if !success {
            NSLog("could not write log to file (error = \(error?.localizedDescription))")
        }
    }


    private func truncateLogFile()
    {
        var error : NSError?
        let success = "".writeToFile(logfilePath, atomically:true, encoding:NSUTF8StringEncoding, error:&error)

        if !success {
            NSLog("could not truncate log file '\(logfilePath)' (error = \(error?.localizedDescription))")
        }
    }
}
