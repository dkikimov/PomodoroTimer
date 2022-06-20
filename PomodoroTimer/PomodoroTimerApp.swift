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


class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject, NSMenuDelegate {
    private var statusItem: NSStatusItem!
    private var popover: NSPopover!
    private var menu: NSMenu!
    private var timerVM: TimerViewModel!
    
    @MainActor func applicationDidFinishLaunching(_ notification: Notification) {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        self.timerVM = TimerViewModel()
        self.menu = NSMenu()
        self.menu.delegate = self
        self.menu.addItem(withTitle: "Выйти", action: #selector(quitApp), keyEquivalent: "q")
        if let statusButton = statusItem.button {
            statusButton.image = NSImage (systemSymbolName: "timer", accessibilityDescription: "PomodoroTimer")
            statusButton.action = #selector(togglePopover(sender:))
            statusButton.sendAction(on: [.leftMouseUp, .rightMouseUp])
        }
        self.popover = NSPopover()
        self.popover.contentSize = NSSize(width: 300, height: 300)
        self.popover.behavior = .transient
        self.popover.contentViewController = NSHostingController(rootView: MainView(viewModel: self.timerVM))
    }
    @objc func togglePopover(sender: NSStatusBarButton) {
        let event = NSApp.currentEvent!
        if event.type == .rightMouseUp {
            statusItem.menu = menu
            statusItem.button?.performClick(nil)
        }
        else {
            if let button = statusItem.button {
                if popover.isShown {
                    self.popover.performClose(nil)
                } else {
                    popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
                }
            }
        }
    }
    @objc func menuDidClose(_ menu: NSMenu) {
        statusItem.menu = nil
    }
    
    @objc func quitApp() {
        NSApp.terminate(self)
    }
}


