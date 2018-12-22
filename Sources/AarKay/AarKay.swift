//
//  AarKay.swift
//  AarKay
//
//  Created by RahulKatariya on 21/08/18.
//

import Foundation
import AarKayKit
import Yams

public class AarKay {
    
    /// Project Url
    public let url: URL
    
    /// The File Manager
    let fileManager: FileManager
    
    /// AarKayFiles url directory relative to path
    lazy var aarkayFilesUrl: URL = {
        return url.appendingPathComponent("AarKay/AarKayData", isDirectory: true)
    }()
    
    lazy var aarkayContext: [String: Any]? = {
        let aarkayLocalContextUrl = aarkayFilesUrl.appendingPathComponent(".aarkay")
        guard let contents = try? String(contentsOf: aarkayLocalContextUrl) else {
            return nil
        }
        return try? YamlInputSerializer.load(contents) as? [String: Any] ?? [:]
    }()
    
    /// Initializer
    public init?(url: URL, fileManager: FileManager = FileManager.default) {
        self.url = url
        self.fileManager = fileManager
    }
    
    public func bootstrap(force: Bool = false) {
        
        AarKayLogger.logTable(url: url, datafilesUrl: aarkayFilesUrl)
        
        guard FileManager.default.fileExists(atPath: aarkayFilesUrl.path) else {
            AarKayLogger.logNoDatafiles(); return
        }
        
        if !force {
            if fileManager.git.isDirty(url: url) {
                AarKayLogger.logDirtyRepo(); return
            }
        }
        
        let urls = try? FileManager.default.contentsOfDirectory(
            at: aarkayFilesUrl,
            includingPropertiesForKeys: [.isDirectoryKey],
            options: .skipsHiddenFiles
        )
        
        urls?.filter { FileManager.default.isDirectory(url: $0) ?? true }
            .forEach {
                
                let plugin = $0.lastPathComponent
                
                let mirror = DirTreeMirror(sourceUrl: $0, destinationUrl: url)
                mirror.bootstrap { ( sourceUrl: URL, destinationUrl: URL) in
                    
                    guard !sourceUrl.lastPathComponent.hasPrefix(".") else { return }
                    
                    AarKayLogger.logDatafile(at: sourceUrl)
                    
                    let nameTemplate = NameTemplate(string: sourceUrl.lastPathComponent)
                    let contents = try! String(contentsOf: sourceUrl)
                    
                    do {
                        let renderedfiles = try AarKayKit.bootstrap(plugin: plugin,
                                                                    globalContext: aarkayContext,
                                                                    fileName: nameTemplate.name,
                                                                    template: nameTemplate.template,
                                                                    contents: contents)
                        
                        renderedfiles.forEach { renderedfile in
                            switch renderedfile {
                            case .success(let value):
                                createFile(
                                    renderedfile: value,
                                    at: destinationUrl.deletingLastPathComponent()
                                )
                            case .failure(let error):
                                AarKayLogger.logError(error)
                            }
                        }
                    } catch {
                        AarKayLogger.logError(error)
                    }
                    
                }
                
        }
        
        AarKayLogger.waitForCompletion()
    }
    
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
            if fileManager.fileExists(atPath: url.path) {
                if override {
                    let currentString = try! String(contentsOf: url)
                    let string = stringBlock(currentString)
                    if string != currentString {
                        try string.write(toFile: url.path, atomically: true, encoding: .utf8)
                        AarKayLogger.logFileModified(at: url)
                    } else {
                        AarKayLogger.logFileSkipped(at: url)
                    }
                } else {
                    AarKayLogger.logFileSkipped(at: url)
                }
            } else {
                let string = stringBlock(nil)
                try? fileManager.createDirectory(at: url.deletingLastPathComponent(), withIntermediateDirectories: true, attributes: nil)
                try string.write(toFile: url.path, atomically: true, encoding: .utf8)
                AarKayLogger.logFileAdded(at: url)
            }
        } catch {
            AarKayLogger.logError(error)
        }
    }
    
}
