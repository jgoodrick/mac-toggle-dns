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
    
    var statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)
    let noDNSServerSetImage = NSImage(named:NSImage.Name("StatusBarButtonImage"))
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let currentDNS = getDNS()
        statusItem.length = 100
        if let button = statusItem.button {
            button.action = #selector(runExecutable)
            if let currentDNSString = currentDNS {
                button.title = currentDNSString
            } else {
                resetButtonToDefaultImage()
            }
        }
        
    }
    
    func getDNS() -> String? {
        let getDNSPath = "/usr/local/bin/getDNS"
        let getDNSProcess = Process()
        getDNSProcess.launchPath = getDNSPath
        let pipe = Pipe()
        getDNSProcess.standardOutput = pipe
        getDNSProcess.launch()
        getDNSProcess.waitUntilExit()
        let fileData = pipe.fileHandleForReading.readDataToEndOfFile()
        if let stringifiedFileData = String(data: fileData, encoding: String.Encoding.utf8)?.trimEverything {
            return stringifiedFileData
        } else {
            return nil
        }
    }
    
    func resetButtonToDefaultImage() {
        statusItem.title = nil
        statusItem.image = noDNSServerSetImage
    }
    
    @objc func runExecutable() {
        
        let toggleDNSPath = "/usr/local/bin/toggleDNS"
        let toggleDNSProcess = Process.launchedProcess(launchPath: toggleDNSPath, arguments: [])
        toggleDNSProcess.waitUntilExit()
        
        let newDNS = getDNS()
        if let newDNSString = newDNS {
            statusItem.title = newDNSString
        } else {
            resetButtonToDefaultImage()
        }
    }
    
    
    
}

fileprivate extension String {
    var trimEverything: String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}

