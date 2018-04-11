//
//  DNSManager+AppLifecycle.swift
//  ToggleDNS
//
//  Created by Joseph Goodrick on 4/6/18.
//  Copyright © 2018 G.O.O.D. Corp. All rights reserved.
//

import Cocoa

protocol AppLifecycle {
    func terminate()
}

extension DNSManager: AppLifecycle {
    ///Resets the dns servers upon exiting the application
    func terminate() {
        restoreServers()
    }
}
