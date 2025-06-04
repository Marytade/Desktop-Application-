//
//  WindowPinManager.swift
//  Pin-proj
//
//  Created by Mary Adebayo on 6/3/25.
//

import Cocoa
import ApplicationServices

struct WindowPinManager {
    static func pinFrontmostWindow(to frame: CGRect) {
        guard let app = NSWorkspace.shared.frontmostApplication else {
            print("❌ No frontmost app.")
            return
        }

        let pid = app.processIdentifier
        print("🔍 Frontmost app: \(app.localizedName ?? "Unknown") [PID \(pid)]")

        let appRef = AXUIElementCreateApplication(pid)

        var focusedWindow: CFTypeRef?
        let result = AXUIElementCopyAttributeValue(appRef, kAXFocusedWindowAttribute as CFString, &focusedWindow)

        if result != .success {
            print("❌ AXUIElementCopyAttributeValue failed with code: \(result.rawValue)")
            return
        }

        guard let windowRef = focusedWindow else {
            print("❌ focusedWindow is nil")
            return
        }

        var origin = CGPoint(x: frame.origin.x, y: frame.origin.y)
        if let posValue = AXValueCreate(.cgPoint, &origin) {
            let setPos = AXUIElementSetAttributeValue(windowRef as! AXUIElement, kAXPositionAttribute as CFString, posValue)
            print("📦 Set position result: \(setPos.rawValue)")
        } else {
            print("❌ Failed to create AXValue for position.")
        }

        var size = CGSize(width: frame.size.width, height: frame.size.height)
        if let sizeValue = AXValueCreate(.cgSize, &size) {
            let setSize = AXUIElementSetAttributeValue(windowRef as! AXUIElement, kAXSizeAttribute as CFString, sizeValue)
            print("📦 Set size result: \(setSize.rawValue)")
        } else {
            print("❌ Failed to create AXValue for size.")
        }
    }
}
