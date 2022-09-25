//
//  Screen.swift
//  RobotKit
//
//  Created by Leif on 8/27/22.
//

import Foundation

/// Robot information of the screen
public struct RobotScreen: SelfTasking {
    /// Get the bounds of the display
    public func bounds(display: CGDirectDisplayID = CGMainDisplayID()) -> CGRect {
        CGDisplayBounds(display)
    }
    
    /// Get the center point of the bounds of the display
    public func center(display: CGDirectDisplayID = CGMainDisplayID()) -> CGPoint {
        let bounds = bounds(display: display)
        return CGPoint(x: bounds.width / 2, y: bounds.height / 2)
    }
    
    /// Get the top center point of the bounds of the display
    public func topCenter(display: CGDirectDisplayID = CGMainDisplayID()) -> CGPoint {
        let bounds = bounds(display: display)
        return CGPoint(x: bounds.midX, y: bounds.minY)
    }
    
    /// Get the bottom center point of the bounds of the display
    public func bottomCenter(display: CGDirectDisplayID = CGMainDisplayID()) -> CGPoint {
        let bounds = bounds(display: display)
        return CGPoint(x: bounds.midX, y: bounds.maxY)
    }
    
    /// Get the left center point of the bounds of the display
    public func leftCenter(display: CGDirectDisplayID = CGMainDisplayID()) -> CGPoint {
        let bounds = bounds(display: display)
        return CGPoint(x: bounds.minX, y: bounds.midY)
    }
    
    /// Get the right center point of the bounds of the display
    public func rightCenter(display: CGDirectDisplayID = CGMainDisplayID()) -> CGPoint {
        let bounds = bounds(display: display)
        return CGPoint(x: bounds.maxX, y: bounds.midY)
    }
    
    /// Get the top left point of the bounds of the display
    public func topLeft(display: CGDirectDisplayID = CGMainDisplayID()) -> CGPoint {
        let bounds = bounds(display: display)
        return CGPoint(x: bounds.minX, y: bounds.minY)
    }
    
    /// Get the top right point of the bounds of the display
    public func topRight(display: CGDirectDisplayID = CGMainDisplayID()) -> CGPoint {
        let bounds = bounds(display: display)
        return CGPoint(x: bounds.maxX, y: bounds.minY)
    }
    
    /// Get the bottom left point of the bounds of the display
    public func bottomLeft(display: CGDirectDisplayID = CGMainDisplayID()) -> CGPoint {
        let bounds = bounds(display: display)
        return CGPoint(x: bounds.minX, y: bounds.maxY)
    }
    
    /// Get the bottom right point of the bounds of the display
    public func bottomRight(display: CGDirectDisplayID = CGMainDisplayID()) -> CGPoint {
        let bounds = bounds(display: display)
        return CGPoint(x: bounds.maxX, y: bounds.maxY)
    }
    
    /// Create an image of the display for a certain CGRect
    public func image(
        display: CGDirectDisplayID = CGMainDisplayID(),
        rect: CGRect
    ) -> CGImage? {
        CGDisplayCreateImage(display, rect: rect)
    }
}
