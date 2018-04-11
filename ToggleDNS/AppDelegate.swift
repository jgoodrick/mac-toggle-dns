//
//  AppDelegate.swift
//  ToggleDNS
//
//  Created by Joseph Goodrick on 3/23/18.
//  Copyright © 2018 G.O.O.D. Corp. All rights reserved.
//

import Cocoa


@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.variableLength)
    let dnsManager: DNSManager = DNSManager()
    lazy var menu: DNSMenu = DNSMenu(with: dnsManager)
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if let button = statusItem.button {
            button.action = #selector(mouseClickHandler(sender:))
            button.sendAction(on: [.leftMouseUp, .rightMouseUp])
        }
        updateUI()
    }
    
    func updateUI() {
        if let topServer = dnsManager.currentDNS?.components(separatedBy: " ").first {
            if topServer != "" {
                statusItem.title = topServer
            } else {
                statusItem.image = NSImage(named:NSImage.Name("StatusBarIcon"))
            }
        } else {
            statusItem.image = NSImage(named:NSImage.Name("StatusBarIcon"))
        }
    }
    
    @objc func mouseClickHandler(sender: NSStatusItem) {
        
        let event = NSApp.currentEvent!
        
        if event.type == NSEvent.EventType.rightMouseUp {
            statusItem.popUpMenu(menu)
        } else {
            //TODO: - Currently, the right click is being sent to clicking the "Go!" menu item with the right mouse button
            dnsManager.toggle()
            updateUI()
        }
        
    }
    
    ///Clears the servers in the System Preferences list (begin using router default)
    @objc func clearServersToDefault() {
        dnsManager.currentDNS = "empty"
        updateUI()
    }

    func dismissMenu() {
        menu.cancelTracking()
    }
    
    @objc func terminateApp() {
        dnsManager.terminate()
        NSApplication.shared.terminate(self)
    }

    
}




