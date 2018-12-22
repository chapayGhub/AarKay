//
//  DirTreeMirror.swift
//  AarKay
//
//  Created by Rahul Katariya on 13/10/17.
//  Copyright © 2017 RahulKatariya. All rights reserved.
//

import Foundation

public class DirTreeMirror {
    
    let sourceUrl: URL
    let destinationUrl: URL
    
    var subUrls: [URL] {
        let subpaths = FileManager.default.subpaths(atPath: sourceUrl.path)
        return subpaths?
            .filter { return !$0.hasPrefix(".") }
            .map {
                return URL(
                    fileURLWithPath: $0,
                    isDirectory: sourceUrl.appendingPathComponent($0).hasDirectoryPath,
                    relativeTo: sourceUrl
                )
            } ?? []
    }
    
    public init(sourceUrl: URL, destinationUrl: URL) {
        self.sourceUrl = sourceUrl
        self.destinationUrl = destinationUrl
    }
    
    public func bootstrap(fileBlock: (URL, URL) -> ()) {
        subUrls.forEach {
            let newUrl = URL(fileURLWithPath: $0.relativePath, isDirectory: $0.hasDirectoryPath, relativeTo: destinationUrl)
            let directoryUrl = newUrl.hasDirectoryPath ? newUrl : newUrl.deletingLastPathComponent()
            try! FileManager.default.createDirectory(at: directoryUrl, withIntermediateDirectories: true, attributes: nil)
            if !$0.hasDirectoryPath { fileBlock($0, newUrl) }
        }
    }
    
}
