//
//  Mouse.swift
//  RobotKit
//
//  Created by Leif on 8/27/22.
//

import Foundation

/// Robot control of the mouse
public actor RobotMouse: SelfTasking {
    private var mouseDisplayID: CGDirectDisplayID
    private var mouseLocation: CGPoint
    
    init(
        initialMouseDisplayID: CGDirectDisplayID = CGMainDisplayID(),
        initialMouseLocation: CGPoint
    ) {
        mouseDisplayID = initialMouseDisplayID
        mouseLocation = initialMouseLocation
    }
    
    /// Move the mouse to the display and point
    public func move(
        displayID: CGDirectDisplayID = CGMainDisplayID(),
        to: CGPoint
    ) {
        mouseDisplayID = displayID
        mouseLocation = to
        CGDisplayMoveCursorToPoint(
            mouseDisplayID,
            mouseLocation
        )
    }
    
    /// Click the left mouse button
    public func leftClick() {
        CGEvent(
            mouseEventSource: nil,
            mouseType: .leftMouseDown,
            mouseCursorPosition: mouseLocation,
            mouseButton: .left
        )?.post(tap: .cghidEventTap)
        
        usleep(500_000)
        
        CGEvent(
            mouseEventSource: nil,
            mouseType: .leftMouseUp,
            mouseCursorPosition: mouseLocation,
            mouseButton: .left
        )?.post(tap: .cghidEventTap)
    }
    
    /// Click the right mouse button
    public func rightClick() {
        CGEvent(
            mouseEventSource: nil,
            mouseType: .rightMouseDown,
            mouseCursorPosition: mouseLocation,
            mouseButton: .right
        )?.post(tap: .cghidEventTap)
        
        usleep(500_000)
        
        CGEvent(
            mouseEventSource: nil,
            mouseType: .rightMouseUp,
            mouseCursorPosition: mouseLocation,
            mouseButton: .right
        )?.post(tap: .cghidEventTap)
    }
}
