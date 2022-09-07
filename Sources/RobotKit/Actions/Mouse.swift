//
//  Mouse.swift
//  RobotKit
//
//  Created by Leif on 8/27/22.
//

import Foundation
import AppKit

/// Robot control of the mouse
public actor RobotMouse: SelfTasking {
    private var mouseDisplayID: CGDirectDisplayID
    private var mouseLocation: CGPoint
    
    private var globalEventMonitor: Any?
    private var localEventMonitor: Any?
    
    /// Computed property to know if the RobotMouse is observing mouse movement
    public var isObserving: Bool {
        globalEventMonitor != nil && localEventMonitor != nil
    }
    
    deinit { stopMonitor() }
    
    init(
        initialMouseDisplayID: CGDirectDisplayID = CGMainDisplayID(),
        initialMouseLocation: CGPoint
    ) {
        mouseDisplayID = initialMouseDisplayID
        mouseLocation = initialMouseLocation
    }
    
    /// Start monitoring mouse movement events
    public func startMonitor() {
        globalEventMonitor = NSEvent.addGlobalMonitorForEvents(
            matching: [.mouseMoved],
            handler: { mouseMovementEvent in
                self.mouseLocation = CGPoint(
                    x: mouseMovementEvent.locationInWindow.x,
                    y: mouseMovementEvent.locationInWindow.y
                )
                print(self.mouseLocation)
            }
        )
        
        localEventMonitor = NSEvent.addLocalMonitorForEvents(
            matching: [.mouseMoved],
            handler: { mouseMovementEvent in
                self.mouseLocation = CGPoint(
                    x: mouseMovementEvent.locationInWindow.x,
                    y: mouseMovementEvent.locationInWindow.y
                )
                print(self.mouseLocation)
                return mouseMovementEvent
            }
        )
    }
    
    /// Stop monitoring mouse movement events
    public func stopMonitor() {
        if let localEventMonitor = localEventMonitor {
            NSEvent.removeMonitor(localEventMonitor)
        }
        
        if let globalEventMonitor = globalEventMonitor {
            NSEvent.removeMonitor(globalEventMonitor)
        }
        
        localEventMonitor = nil
        globalEventMonitor = nil
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
