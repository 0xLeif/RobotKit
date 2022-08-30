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
    
    /// Create an image of the display for a certain CGRect
    public func image(
        display: CGDirectDisplayID = CGMainDisplayID(),
        rect: CGRect
    ) -> CGImage? {
        CGDisplayCreateImage(display, rect: rect)
    }
}
