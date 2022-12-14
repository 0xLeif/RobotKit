//
//  Notification.swift
//  RobotKit
//
//  Created by Ahmed Shendy on 29/08/2022.
//

import UserNotifications

/// Robot control of notification center and its delegate
public actor RobotNotification: SelfTasking {
    private class DefaultNotificationCenterDelegate: NSObject, UNUserNotificationCenterDelegate {
        func userNotificationCenter(
            _ center: UNUserNotificationCenter,
            willPresent notification: UNNotification,
            withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
        ) {
            if #available(macOS 11.0, *) {
                completionHandler([.banner, .sound, .badge])
            } else {
                completionHandler([.sound, .badge])
            }
        }
        
        func userNotificationCenter(
            _ center: UNUserNotificationCenter,
            didReceive response: UNNotificationResponse,
            withCompletionHandler completionHandler: @escaping () -> Void
        ) { completionHandler() }
    }
    
    private var current: UNUserNotificationCenter? {
        if
            let bundleIdentifier = Bundle.main.bundleIdentifier,
            bundleIdentifier.contains("xctest")
        { return nil }
        
        let notificationCenter = UNUserNotificationCenter.current()
        
        if notificationCenter.delegate == nil {
            notificationCenter.delegate = delegate
        }
        
        return notificationCenter
    }
    
    public var delegate: UNUserNotificationCenterDelegate = DefaultNotificationCenterDelegate() {
        didSet {
            current?.delegate = delegate
        }
    }
    
    init() { }
    
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
        guard let current = current else { return false }

        do {
            return try await current.requestAuthorization(options: options)
        } catch {
            return false
        }
    }
    
    /// Send notification message to user
    public func push(title: String, subtitle: String?, message: String) async throws {
        guard
            let current = current,
            await getAuthorizationStatus() == .authorized
        else { return }
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = message
        if let subtitle = subtitle {
            content.subtitle = subtitle
        }
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: UNTimeIntervalNotificationTrigger(timeInterval: 0.01, repeats: false)
        )
        
        Task { @MainActor in
            try await current.add(request)
        }
    }
    
    public func getAuthorizationStatus() async -> UNAuthorizationStatus {
        guard let current = current else { return .notDetermined }

        return await current.notificationSettings().authorizationStatus
    }
}
