//
//  FileManagerExtensions.swift
//  AarKay
//
//  Created by Rahul Katariya on 03/03/18.
//

import Foundation

extension FileManager {
    
    var aarkayRunnerDirectory: URL {
        return URL(fileURLWithPath: NSHomeDirectory())
            .appendingPathComponent("AarKay/AarKayRunner", isDirectory: true)
    }
    
    var aarkayBuildDirectory: URL {
        return aarkayRunnerDirectory
            .appendingPathComponent(".build", isDirectory: true)
    }
    
    var aarkayCLI: URL {
        return aarkayBuildDirectory
            .appendingPathComponent("debug/aarkay-cli", isDirectory: false)
    }
    
    var aarkayServer: URL {
        return aarkayBuildDirectory
            .appendingPathComponent("debug/aarkay-server", isDirectory: false)
    }
    
}
