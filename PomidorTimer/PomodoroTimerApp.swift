//
//  PomodoroTimerApp.swift
//  PomodoroTimerApp
//
//  Created by Даник 💪 on 09.06.2022.
//

import SwiftUI

@main
struct PomodoroTimerApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    var body: some Scene {
        Settings {
            MainView(viewModel: TimerViewModel())
        }
    }
}


class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject {
    private var statusItem: NSStatusItem!
    private var popover: NSPopover!
    
    private var timerVM: TimerViewModel!
    
    @MainActor func applicationDidFinishLaunching(_ notification: Notification) {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        self.timerVM = TimerViewModel()
        if let statusButton = statusItem.button {
            statusButton.image = NSImage (systemSymbolName: "timer", accessibilityDescription: "PomodoroTimer")
            statusButton.action = #selector(togglePopover)
        }
        self.popover = NSPopover()
        self.popover.contentSize = NSSize(width: 300, height: 300)
        self.popover.behavior = .transient
        self.popover.contentViewController = NSHostingController(rootView: MainView(viewModel: self.timerVM))
    }
    @objc func togglePopover() {
        if let button = statusItem.button {
            if popover.isShown {
                self.popover.performClose(nil)
            } else {
                popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            }
        }
    }
}


