//
//  AppDelegate.swift
//  Pin-proj
//
//  Created by Mary Adebayo on 6/3/25.
//

import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSPanel!

    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = ContentView()

        let panel = NSPanel(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 320),
            styleMask: [.titled, .nonactivatingPanel, .closable, .miniaturizable],
            backing: .buffered,
            defer: false
        )

        panel.title = "Pin-Pin"
        panel.isFloatingPanel = true
        panel.level = .floating
        panel.collectionBehavior = [
            .canJoinAllSpaces,
            .fullScreenAuxiliary,
            .stationary
        ]
        panel.isReleasedWhenClosed = false
        panel.hidesOnDeactivate = false
        panel.isMovableByWindowBackground = true
        panel.backgroundColor = .clear
        panel.isOpaque = false
        panel.standardWindowButton(.zoomButton)?.isHidden = true

        panel.contentView = NSHostingView(rootView: contentView)

        if let screen = NSScreen.main {
            let screenFrame = screen.visibleFrame
            let origin = CGPoint(x: screenFrame.minX, y: screenFrame.maxY - 320)
            panel.setFrameOrigin(origin)
        }

        panel.orderFrontRegardless()
        self.window = panel
    }
}
