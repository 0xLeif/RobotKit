//
//  Notification.swift
//  RobotKit
//
//  Created by Ahmed Shendy on 29/08/2022.
//

#if RELEASE
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
    
    init() {
        current.delegate = delegate
    }
    
    /// Request notification permission from user if needed
    @discardableResult
    public func requestAuthorizationIfNeeded(options: UNAuthorizationOptions = [.alert, .sound]) async -> Bool {
        guard await getAuthorizationStatus() != .authorized else {
            return await requestAuthorization(options: options)
        }
        
        return true
    }
    
    /// Request notification permission from user
    @discardableResult
    public func requestAuthorization(options: UNAuthorizationOptions = [.alert, .sound]) async -> Bool {
        do {
            return try await current.requestAuthorization(options: options)
        } catch {
            return false
        }
    }
    
    /// Send notification message to user
    public func push(title: String, subtitle: String?, message: String) async throws {
        guard await getAuthorizationStatus() == .authorized else { return }
        
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
        
        try await current.add(request)
    }
    
    public func getAuthorizationStatus() async -> UNAuthorizationStatus {
        return await current.notificationSettings().authorizationStatus
    }
}
#endif
