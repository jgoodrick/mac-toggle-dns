//
//  DNSManager+ActionHandler.swift
//  ToggleDNS
//
//  Created by Joseph Goodrick on 4/6/18.
//  Copyright © 2018 G.O.O.D. Corp. All rights reserved.
//

import Cocoa

protocol HandlesLeftClick {
    func uponLeftClick()
}

extension DNSManager: HandlesLeftClick {
    func uponLeftClick() {
        toggle()
    }
}
