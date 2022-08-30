//
//  Robot.swift
//  RobotKit
//
//  Created by Leif on 8/27/22.
//

import AppKit

/// `Robot` uses CoreGraphics to generate native mouse and keyboard input. It can also get information about the screen like the bounds, center, or even generating an image. `Robot` also can use [Vision](https://developer.apple.com/documentation/vision) to read text for an image.
public actor Robot: SelfTasking {
    // MARK: - Singleton
    
    /// The default and only Robot that should be used.
    public static let `default`: Robot = Robot()
    
    /// Create an async rethrowing function using the default Robot
    public static func task(
        _ work: @escaping (Robot) async throws -> Void
    ) async rethrows { try await work(Robot.default) }
    
    // MARK: - Properties
    
    /// Robot control of the mouse
    public let mouse = RobotMouse(
        initialMouseLocation: .zero
    )
    
    /// Robot control of the keyboard
    public let keyboard = RobotKeyboard()
    
    /// Robot information of the screen
    public let screen = RobotScreen()
    
    /// Robot information using [Vision](https://developer.apple.com/documentation/vision)
    public let vision = RobotVision()
    
    #if RELEASE
    /// Robot control of notification center
    public let notification = RobotNotification()
    #endif
    
    /// Robot information of the NSApplication
    @MainActor
    public let application = NSApplication.shared
    
    private init() { }
}
