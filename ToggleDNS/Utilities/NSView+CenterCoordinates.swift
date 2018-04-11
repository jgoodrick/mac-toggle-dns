//
//  NSView+CenterCoordinates.swift
//  ToggleDNS
//
//  Created by Joseph Goodrick on 4/10/18.
//  Copyright © 2018 G.O.O.D. Corp. All rights reserved.
//

import Cocoa

extension NSView {
    var centerX: CGFloat {return (self.frame.origin.x + (self.frame.size.width / 2))}
    var centerY: CGFloat {return (self.frame.origin.y + (self.frame.size.height / 2))}
}
