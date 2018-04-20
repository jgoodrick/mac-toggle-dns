//
//  ScriptRunner.swift
//  ToggleDNS
//
//  Created by Joseph Goodrick on 4/5/18.
//  Copyright © 2018 G.O.O.D. Corp. All rights reserved.
//

import Cocoa

class ScriptRunner {
    func runBash(command: [String]) -> String? {
        let bashPath = "/bin/bash"
        let process = Process()
        process.launchPath = bashPath
        process.arguments = command
        let pipe = Pipe()
        process.standardOutput = pipe
        process.launch()
        process.waitUntilExit()
        let fileData = pipe.fileHandleForReading.readDataToEndOfFile()
        return String(data: fileData, encoding: String.Encoding.utf8)?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}

