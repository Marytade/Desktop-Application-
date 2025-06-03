//
//  Pin_projApp.swift
//  Pin-proj
//
//  Created by Mary Adebayo on 6/3/25.
//

import SwiftUI

@main
struct PinPinApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(width: 1440, height: 900)
        }
        .windowStyle(HiddenTitleBarWindowStyle()) // Optional: hides title bar
        .defaultSize(width: 1440, height: 900)
        .commands {
            // Remove default menu bar items if you want a more pop-up feel
        }
    }

    init() {
        // Set window position on launch — top-left corner
        DispatchQueue.main.async {
            if let window = NSApplication.shared.windows.first {
                window.setFrame(NSRect(x: 0, y: NSScreen.main!.frame.height - 900, width: 1440, height: 900), display: true)
            }
        }
    }
}
