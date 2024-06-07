//
//  AppDelegate.swift
//  Example macOS
//
//  Created by Valentin Perignon on 07.06.2024.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}
