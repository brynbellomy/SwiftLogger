//
//  ColorLogging.swift
//  SwiftLogger
//
//  Created by bryn austin bellomy on 2014 Aug 17.
//  Copyright (c) 2014 bryn austin bellomy. All rights reserved.
//

import Foundation
import Cocoa

#if os(iOS)
    typealias OSColor = UIColor
#elseif os(OSX)
    typealias OSColor = NSColor
#endif

/**
    Global singleton-ish object containing helpers for logging colorized output to the Xcode console.
 */
public struct ColorLogging
{
    public struct RGB
    {
        public var r : UInt8
        public var g : UInt8
        public var b : UInt8

        public init(r:UInt8, g:UInt8, b:UInt8) {
            self.r = r
            self.g = g
            self.b = b
        }

        public init(nscolor:NSColor) {
            var red   : CGFloat = 0
            var green : CGFloat = 0
            var blue  : CGFloat = 0
            var alpha : CGFloat = 0

            nscolor.getRed(&red, green:&green, blue:&blue, alpha:&alpha)

            var r = UInt8(red * 255)
            var g = UInt8(green * 255)
            var b = UInt8(blue * 255)

            self = RGB(r:r, g:g, b:b)
        }
    }

    public struct Colorize
    {
        public static func Foreground(rgb:RGB, text:String) -> String { return Constants.EscapeCodes.Foreground(rgb) + text + Constants.EscapeCodes.Reset }

        public static func White(text:String)      -> String { return Constants.EscapeCodes.Foreground(Colors.White) + text + Constants.EscapeCodes.Reset }
        public static func Red(text:String)        -> String { return Constants.EscapeCodes.Foreground(Colors.Red)   + text + Constants.EscapeCodes.Reset }
        public static func Yellow(text:String)     -> String { return Constants.EscapeCodes.Foreground(Colors.Yellow)   + text + Constants.EscapeCodes.Reset }
        public static func Orange(text:String)     -> String { return Constants.EscapeCodes.Foreground(Colors.Orange)   + text + Constants.EscapeCodes.Reset }
        public static func Olive(text:String)      -> String { return Constants.EscapeCodes.Foreground(Colors.Olive)   + text + Constants.EscapeCodes.Reset }
        public static func Green(text:String)      -> String { return Constants.EscapeCodes.Foreground(Colors.Green)   + text + Constants.EscapeCodes.Reset }
        public static func Purple(text:String)     -> String { return Constants.EscapeCodes.Foreground(Colors.Purple) + text + Constants.EscapeCodes.Reset }
        public static func Blue(text:String)       -> String { return Constants.EscapeCodes.Foreground(Colors.Blue)  + text + Constants.EscapeCodes.Reset }
        public static func LightBlue(text:String)  -> String { return Constants.EscapeCodes.Foreground(Colors.LightBlue) + text + Constants.EscapeCodes.Reset }
        public static func Grey(text:String)       -> String { return Constants.EscapeCodes.Foreground(Colors.Grey) + text + Constants.EscapeCodes.Reset }
    }

    public struct Colors
    {
        public static let White     = RGB(r:255, g:255, b:255)
        public static let Red       = RGB(r:178, g:34,  b:34)
        public static let Yellow    = RGB(r:255, g:185, b:0)
        public static let Orange    = RGB(r:225, g:135, b:0)
        public static let Olive     = RGB(r:85,  g:107, b:47)
        public static let Green     = RGB(r:34,  g:139, b:34)
        public static let Purple    = RGB(r:132, g:112, b:255)
        public static let Blue      = RGB(r:30,  g:144, b:255)
        public static let LightBlue = RGB(r:130, g:244, b:255)
        public static let Grey      = RGB(r:160, g:160, b:160)
    }

    public struct Constants
    {
        public struct EscapeCodes
        {
//            #if os(osx)
//                static let Start = XcodeColorsEscapeSequence() //
            static let Start = "\u{1B}["
//            #else
//                static let Start = "\u{C2}\u{A0}["
//            #endif

            static let ResetForeground = "\(Start)fg;"
            static let ResetBackground = "\(Start)bg;"
            static let Reset = "\(Start);"

            static func Foreground(r:UInt8, _ g:UInt8, _ b:UInt8) -> String {
                return Foreground(RGB(r:r, g:g, b:b))
            }

            static func Foreground(rgb:RGB) -> String {
                return "\(Start)fg\(rgb.r),\(rgb.g),\(rgb.b);"
            }

            static func Background(r:UInt, g:UInt, b:UInt) -> String {
                return "\(Start)bg\(r),\(g),\(b);"
            }
        }
    }

}








