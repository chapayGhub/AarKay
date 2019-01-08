//
//  URLExtensions.swift
//  AarKayKit
//
//  Created by Rahul Katariya on 26/06/18.
//

import Foundation

extension FileManager {
    public func subDirectories(atUrl url: URL) -> [URL]? {
        let enumerator = self.enumerator(at: url, includingPropertiesForKeys: [.isDirectoryKey])
        let results = enumerator?
            .map { $0 as! URL }
            .filter {
                if let isDirectory = isDirectory(url: $0) {
                    return isDirectory
                } else {
                    return true
                }
            }
        return results
    }

    public func subFiles(atUrl url: URL) -> [URL]? {
        let enumerator = self.enumerator(at: url, includingPropertiesForKeys: [.isDirectoryKey])
        let results = enumerator?
            .map { $0 as! URL }
            .filter {
                if let isDirectory = isDirectory(url: $0) {
                    return !isDirectory
                } else {
                    return false
                }
            }
        return results
    }

    public func isDirectory(url: URL) -> Bool? {
        #if os(Linux)
        var isDir: ObjCBool = ObjCBool(false)
        if fileExists(atPath: url.path, isDirectory: &isDir) {
            return isDir.boolValue
        } else {
            return nil
        }
        #else
        do {
            return try url.resourceValues(forKeys: [.isDirectoryKey]).isDirectory
        } catch {
            return false
        }
        #endif
    }
}
