//
//  ContentView.swift
//  Example
//
//  Created by Leif on 8/29/22.
//

import RobotKit
import SwiftUI

struct ContentView: View {
    var body: some View {
        Button("Push") {
            Task {
                await Robot.default.mouse.move(to: await Robot.default.screen.center())
                
                try await Robot.default.notification.task { notification in
                    await notification.requestAuthorization()
                    try await notification.push(title: "Hello", subtitle: "Example", message: "Message")
                }
                
                print("End")
            }
        }
        .task {
            await Robot.default.mouse.startMonitor()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
