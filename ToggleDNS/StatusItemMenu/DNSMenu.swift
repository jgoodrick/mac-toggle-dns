//
//  NSStatusItemMenu.swift
//  ToggleDNS
//
//  Created by Joseph Goodrick on 4/5/18.
//  Copyright © 2018 G.O.O.D. Corp. All rights reserved.
//

import Cocoa

class DNSMenu: NSMenu {

    init(with dnsManager: DNSManager) {
        super.init(title: "ToggleDNS")
        
        let textFieldMenuItem = DNSMenuItem(
            with: dnsManager
        )
        let defaultRouterAddressMenuItem = NSMenuItem(
            title: "Default Router Address",
            action: #selector(AppDelegate.clearServersToDefault),
            keyEquivalent: ""
        )
        let quitMenuItem = NSMenuItem(
            title: "Quit",
            action: #selector(AppDelegate.terminateApp),
            keyEquivalent: ""
        )
        
        addItem(textFieldMenuItem)
        addItem(NSMenuItem.separator())
        addItem(defaultRouterAddressMenuItem)
        addItem(NSMenuItem.separator())
        addItem(quitMenuItem)
    }
    
    required init(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
