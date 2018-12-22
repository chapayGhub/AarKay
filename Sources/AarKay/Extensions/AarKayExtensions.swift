//
//  AarKayExtensions.swift
//  AarKay
//
//  Created by RahulKatariya on 21/08/18.
//

import Foundation

extension URL {
    
    public static var aarkayRootDirectoryForCurrentUser: URL {
        return URL.init(fileURLWithPath: NSHomeDirectory())
    }
    
    public static var aarkayDirectoryForCurrentUser: URL {
        return aarkayRootDirectoryForCurrentUser
            .appendingPathComponent("AarKay")
    }
    
    public static var aarkayDataDirectoryForCurrentUser: URL {
        return aarkayDirectoryForCurrentUser
            .appendingPathComponent("AarKayData")
    }
    
}

extension URL {
    
    var relativePathToAarKayRootDirectory: String? {
        let rootPath = URL
            .aarkayRootDirectoryForCurrentUser
            .path
        guard path.hasPrefix(rootPath) else { return nil }
        let index = path.index(rootPath.endIndex, offsetBy: 1)
        return String(path[index...])
    }
    
    var localAarKayDataUrl: URL {
        let localAarKayDataPath = self.appendingPathComponent(
            "AarKay/AarKayData", isDirectory: true
        )
        return localAarKayDataPath
    }
    
    var isEmptyFolder: Bool {
        let status = BashProcess.run(
            command: "[ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1",
            cwd: self
        )
        let contents = try? FileManager.default.contentsOfDirectory(atPath: path)
            .filter { $0 == ".DS_Strore" }
        if let contents = contents, contents.count == 0, status != 0 {
            return true
        }
        return false
    }
    
    var isDirty: Bool {
        if isEmptyFolder { return false }
        return BashProcess.run(
            command: "git diff --quiet HEAD",
            cwd: self
            ) == 0 ? false : true
    }
    
}
