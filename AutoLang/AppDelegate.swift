//
//  AppDelegate.swift
//  AutoLang
//
//  Created by Gustaf Elbander on 2024-06-26.
//

import AppKit

class AppDelegate: NSObject, NSApplicationDelegate {
    private let databaseManager: DatabaseManager
    private let inputSourceManager: InputSourceManager

    override init() {
        self.databaseManager = DatabaseManager()
        self.inputSourceManager = InputSourceManager()
        super.init()
    }

    func run() {
        let app = NSApplication.shared
        app.delegate = self
        app.run()
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        print("Application started and running in the background!")
        
        do {
            try databaseManager.initDB()
            print("Database initialized successfully")
            
            // Set up workspace notification
            NSWorkspace.shared.notificationCenter.addObserver(
                self,
                selector: #selector(activeAppDidChange),
                name: NSWorkspace.didActivateApplicationNotification,
                object: nil
            )
        } catch {
            print("Failed to initialize database: \(error)")
            NSApplication.shared.terminate(nil)
        }
    }
    
    @objc func activeAppDidChange(_ notification: Notification) {
        guard let app = notification.userInfo?[NSWorkspace.applicationUserInfoKey] as? NSRunningApplication,
              let bundleIdentifier = app.bundleIdentifier else {
            print("Failed to get bundle identifier for active app")
            return
        }
        
        print("User switched to: \(bundleIdentifier)")
        
        if let trackedApp = databaseManager.trackedApps.first(where: { $0.name == bundleIdentifier }) {
            print("Special app detected: \(trackedApp.name), Language: \(trackedApp.language)")
            do {
                try inputSourceManager.changeInputSource(to: trackedApp.language)
            } catch {
                print("Failed to change input source: \(error)")
            }
        } else {
            print("App not in tracked list")
        }
    }
}
