//
//  AarKay.swift
//  AarKay
//
//  Created by RahulKatariya on 21/08/18.
//

import Foundation
import AarKayKit
import PrettyColors
import SwiftyTextTable
import Yams

public class AarKay {
    
    /// Project Url
    public let url: URL
    
    /// AarKayFiles url directory relative to path
    let aarkayFilesUrl: URL
    
    lazy var aarkayContext: [String: Any]? = {
        let aarkayLocalContextUrl = aarkayFilesUrl.appendingPathComponent(".aarkay")
        guard let contents = try? String(contentsOf: aarkayLocalContextUrl) else {
            return nil
        }
        return try? YamlInputSerializer.load(contents) as? [String: Any] ?? [:]
    }()
    
    /// Initializer
    public init?(url: URL) {
        guard let path = url.relativePathToAarKayRootDirectory else {
            print("🚫 Current directory should be relative to home directory".red)
            return nil
        }
        
        self.url = url
        
        if let dataUrl = url.localAarKayDataUrl {
            self.aarkayFilesUrl = dataUrl
        } else {
            self.aarkayFilesUrl = {
                let url = URL
                    .aarkayDataDirectoryForCurrentUser
                    .appendingPathComponent(path)
                do {
                    try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
                    FileManager.default.createFile(
                        atPath: url.appendingPathComponent(".aarkay").path,
                        contents: Data(),
                        attributes: nil
                    )
                } catch {
                    print(error.localizedDescription.red); fatalError()
                }
                return url
            }()
        }
        
    }
    
    public func bootstrap(force: Bool = false) {
        let column = TextTableColumn(header: "🚀 Launch---i--n--g--> " + url.path)
        var table = TextTable(columns: [column])
        table.addRow(values: ["🙏🏻 AarKayData-------> " + aarkayFilesUrl.path])
        print(table.render().magenta)
        
        if !force {
            if url.isDirty {
                print("🚫 Please discard or stash all your changes to git or try it inside an empty folder".red)
                return
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
                    
                    print("<^> \(sourceUrl.lastPathComponent)".blue)
                    
                    let contents = try! String(contentsOf: sourceUrl)
                    
                    let nameTemplate = NameTemplate(string: sourceUrl.lastPathComponent)
                    let fileName = nameTemplate.name
                    let template = nameTemplate.template
                    
                    do {
                        let Renderedfiles = try AarKayKit.bootstrap(plugin: plugin,
                                                                    globalContext: aarkayContext,
                                                                    fileName: fileName,
                                                                    template: template,
                                                                    contents: contents)
                        
                        Renderedfiles.forEach { Renderedfile in
                            switch Renderedfile {
                            case .success(let value):
                                FileManager.default.createFile(
                                    renderedfile: value,
                                    at: destinationUrl.deletingLastPathComponent()
                                )
                            case .failure(let error):
                                print("   <!> \(error.localizedDescription)".red)
                            }
                        }
                    } catch {
                        print("   <!> \(error.localizedDescription)".red)
                    }
                    
                }
                
        }
    }
    
}
