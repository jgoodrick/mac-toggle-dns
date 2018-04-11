//
//  NSTextFieldMenuItem.swift
//  ToggleDNS
//
//  Created by Joseph Goodrick on 4/5/18.
//  Copyright © 2018 G.O.O.D. Corp. All rights reserved.
//

import Cocoa

class DNSMenuItem: NSMenuItem, NSMenuDelegate {
    let dnsManager: DNSManager
    let dnsView: DNSMenuItemView
    init(with dnsManager: DNSManager) {
        self.dnsManager = dnsManager
        self.dnsView = DNSMenuItemView(with: dnsManager)
        super.init(
            title: "",
            action: nil,
            keyEquivalent: ""
        )
        view = dnsView
    }
    
    required init(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
