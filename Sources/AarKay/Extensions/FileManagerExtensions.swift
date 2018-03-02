//
//  Renderer.swift
//  AarKay
//
//  Created by RahulKatariya on 22/08/18.
//

import Foundation
import AarKayKit

extension FileManager {

    func createFile(renderedfile: Renderedfile, at url: URL) {
        var url = url
        if let directory = renderedfile.directory {
            url = url
                .appendingPathComponent(directory, isDirectory: true)
                .standardized
        }
        url.appendPathComponent(renderedfile.fileName)
        let stringBlock = renderedfile.stringBlock
        let override = renderedfile.override
        do {
            if fileExists(atPath: url.path) {
                if override {
                    let currentString = try! String(contentsOf: url)
                    let string = stringBlock(currentString)
                    if string != currentString {
                        try string.write(toFile: url.path, atomically: true, encoding: .utf8)
                        print("   <*> \(url.absoluteString)".yellow)
                    } else {
                        print("   <-> \(url.absoluteString)")
                    }
                } else {
                    print("   <-> \(url.absoluteString)")
                }
            } else {
                let string = stringBlock(nil)
                try? createDirectory(at: url.deletingLastPathComponent(), withIntermediateDirectories: true, attributes: nil)
                try string.write(toFile: url.path, atomically: true, encoding: .utf8)
                print("   <+> \(url.absoluteString)".green)
            }
        } catch {
            print("   <!> \(url.absoluteString)".red)
        }
    }
    
}
