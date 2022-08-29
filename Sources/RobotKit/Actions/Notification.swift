//
//  File.swift
//  
//
//  Created by Ahmed Shendy on 29/08/2022.
//

import Foundation
import UserNotifications

/// Robot control of notification center and its delegate
public actor RobotNotification: SelfTasking {
    
    private class DefaultNotificationCenterDelegate: NSObject, UNUserNotificationCenterDelegate { }
    
    private var current: UNUserNotificationCenter = UNUserNotificationCenter.current()
    public var delegate: UNUserNotificationCenterDelegate = DefaultNotificationCenterDelegate() {
        didSet {
            current.delegate = delegate
        }
    }
    
    public var isAuthorized: Bool {
        let settings = await current.notificationSettings()
        
        return settings.authorizationStatus == .authorized
    }
    
    init() {
        current.delegate = delegate
    }
    
    /// Request notification permission from user
    @discardableResult
    public func requestAuthorization(options: UNAuthorizationOptions = [.alert, .sound]) async throws -> Bool {
        return current.requestAuthorization(options: options)
    }
    
    /// Send notification message to user
    public func push(title: String, subtitle: String?, message: String) {
        if isAuthorized {
            let content = UNMutableNotificationContent()
            content.title = title
            content.body = message
            if let subtitle = subtitle {
                content.subtitle = subtitle
            }
            
            let request = UNNotificationRequest(
                identifier: UUID().uuidString,
                content: content,
                trigger: nil
            )
            
            await current.add(request)
        }
    }
}
