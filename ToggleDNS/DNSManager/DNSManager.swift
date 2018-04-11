//
//  DNSManager.swift
//  ToggleDNS
//
//  Created by Joseph Goodrick on 4/5/18.
//  Copyright © 2018 G.O.O.D. Corp. All rights reserved.
//

import Cocoa


class DNSManager: ScriptRunner {
    
    var serversDefinedAtLaunch: String?
    var routerDNSServer: String?
    var _togglingAddress: String = "8.8.8.8"
    var togglingAddress: String {
        get {
            return _togglingAddress
        }
        set {
            let addressToSet = newValue.trimmed
            guard !addressToSet.isEmpty else {return}
            if addressToSet.isValidIPv4() {
                self._togglingAddress = addressToSet
            }
        }
    }
    var currentDNS: String? {
        get {
            if let output = runBash(command: ["-c","scutil --dns | grep 'nameserver' | sort | uniq | cut -f2- -d':' | cut -f2- -d' '"]) {
                return output.replacingOccurrences(of: "\n", with: " ")
            }
            return nil
        }
        set {
            if let address = newValue {
                let output = runBash(command: ["-c", "networksetup -setdnsservers Wi-Fi \(address)"])
                print(output ?? "Set DNS Servers for Wi-Fi to \(address): No Output")
            } else {
                let networksetupArgumentToClearServers = "empty"
                let output = runBash(command: ["-c", "networksetup -setdnsservers Wi-Fi \(networksetupArgumentToClearServers)"])
                print(output ?? "Clearing DNS Servers: No Output")
            }
        }
    }

    override init() {
        super.init()
        storeServers()
    }
    
    ///Store initial servers, if any are set. Prints to console
    func storeServers() {
        if let output = runBash(command: ["-c", "networksetup -getdnsservers Wi-Fi"]) {
            if output != "There aren't any DNS Servers set on Wi-Fi." {
                serversDefinedAtLaunch = output.replacingOccurrences(of: "\n", with: " ")
            } else {
                routerDNSServer = runBash(command: ["-c","scutil --dns | grep 'nameserver' | sort | uniq | cut -f2- -d':' | cut -f2- -d' '"])?.components(separatedBy: "\n").first
                print(routerDNSServer ?? "The router does not provide a local DNS Server")
            }
        }
    }

    ///Restores the server settings to the pre-launch configuration
    func restoreServers() {
        currentDNS = serversDefinedAtLaunch
    }
    
    
    ///Toggles between an empty address list and the toggling address
    func toggle() {
        if currentDNS == serversDefinedAtLaunch || currentDNS == routerDNSServer {
            print("Setting DNS from \(currentDNS ?? "nil") to \(togglingAddress)")
            currentDNS = togglingAddress
        } else {
            if let addresses = serversDefinedAtLaunch {
                print("Restoring DNS Servers to \(addresses)")
            } else if let address = routerDNSServer {
                print("Restoring DNS Server to router default: \(address)")
            } else {
                print("Restoring DNS Server to router default")
            }
            restoreServers()
        }
    }
    
    func attemptToSetTogglingAddressAndCurrentDNS(to newAddress: String) {
        let trimmedAddress = newAddress.trimmed
        attemptNewTogglingAddress(newAddress)
        guard togglingAddress == trimmedAddress else {return}
        if let currentDNS = currentDNS {
            guard currentDNS != trimmedAddress else {return}
        }
        currentDNS = togglingAddress
    }
    
    ///Attempts to set the new toggling address, if valid
    func attemptNewTogglingAddress(_ address: String) {
        let trimmedAddress = address.trimmed
        if trimmedAddress.isValidIPv4() {
            togglingAddress = trimmedAddress
        }
    }
    
}

fileprivate extension String {
    var trimmed: String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}

fileprivate extension String {
    func isValidIPv4() -> Bool {
        let validIpAddressRegex = "^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$"
        let regex = try! NSRegularExpression(pattern: validIpAddressRegex, options: [])
        let matches = regex.matches(in: self, options: [], range: NSRange(location: 0, length: self.count))
        guard !matches.isEmpty else {return false}
        return true
    }
}
