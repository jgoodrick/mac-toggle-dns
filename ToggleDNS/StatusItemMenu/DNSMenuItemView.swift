//
//  NSTextFieldMenuItemView.swift
//  ToggleDNS
//
//  Created by Joseph Goodrick on 3/27/18.
//  Copyright © 2018 G.O.O.D. Corp. All rights reserved.
//

import Cocoa


class DNSMenuItemView: NSView {    
    let dnsManager: DNSManager
    let textField: NSTextField
    let appDelegate = NSApp.delegate as! AppDelegate
    
    init(with dnsManager: DNSManager) {
        self.dnsManager = dnsManager
        self.textField = NSTextField(string: dnsManager.togglingAddress)
        super.init(frame: NSRect(x: 0, y: 0, width: textField.frame.width * 1.5, height: textField.frame.height))
        textField.target = self
        textField.action = #selector(uponReturnKey)
        textField.cell?.sendsActionOnEndEditing = false
        textField.layer?.cornerRadius = 5
        textField.isBordered = true
        textField.translatesAutoresizingMaskIntoConstraints = false

        addSubview(textField)
        
        NSLayoutConstraint(
            item: textField,
            attribute: .left,
            relatedBy: .greaterThanOrEqual,
            toItem: self,
            attribute: .left,
            multiplier: 1.0,
            constant: 20
        ).isActive = true
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    ///Called when the enter key is hit while editing
    @objc func uponReturnKey() {
        var value: String {
            get {return textField.stringValue}
            set {textField.stringValue = newValue}
        }

        dnsManager.attemptNewTogglingAddress(value)
        if dnsManager.togglingAddress != value {
            value = dnsManager.togglingAddress
        } else {
            appDelegate.dismissMenu()
            if let currentDNS = dnsManager.currentDNS {
                guard currentDNS != value else {return}
            }
            dnsManager.attemptToSetTogglingAddressAndCurrentDNS(to: value)
            appDelegate.updateUI()
        }
    }


}

