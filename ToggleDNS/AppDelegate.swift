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
    
    let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if let button = statusItem.button {
            button.image = NSImage(named:NSImage.Name("StatusBarButtonImage"))
            button.action = #selector(runExecutable)
        }
        
    }
    
    @objc func runExecutable() {
        let path = "/bin/bash"
        let arguments: [String] = ["/usr/local/bin/toggleDNS"]
        print("going to start process")
        let process = Process.launchedProcess(launchPath: path, arguments: arguments)
        print("created process")
        process.waitUntilExit()
        print("finished process")
    }
    
}

