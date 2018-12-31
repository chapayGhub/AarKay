//
//  AarKay.swift
//  AarKay
//
//  Created by RahulKatariya on 21/08/18.
//

import AarKayKit
import Foundation

/// Represents an AarKay Project.
public class AarKay {
    
    /// The project url.
    public let url: URL
    
    /// The options.
    let options: AarKayOptions
    
    /// The file manager.
    let fileManager: FileManager
    
    /// The data files url relative to the project url.
    lazy var aarkayFilesUrl: URL = {
        return url.appendingPathComponent("AarKay/AarKayData", isDirectory: true)
    }()
    
    /// Constructs an `AarKay` project.
    ///
    /// - Parameters:
    ///   - url: The url of project directory where files will be generated.
    ///   - options: The options.
    ///   - fileManager: The file manager.
    public init(
        url: URL,
        options: AarKayOptions = AarKayOptions(),
        fileManager: FileManager = FileManager.default
    ) {
        self.url = url
        self.options = options
        self.fileManager = fileManager
    }
    
    /// Bootstrap files generation process.
    public func bootstrap() {
        /// Wait for all logs to be printed on console before terminating the program.
        defer { AarKayLogger.waitForCompletion() }
        
        /// Log the url and AarkayFiles url.
        AarKayLogger.logTable(url: url, datafilesUrl: aarkayFilesUrl)
        
        /// Log if the AarKayFiles directory is empty.
        guard FileManager.default.fileExists(atPath: aarkayFilesUrl.path) else {
            // FIXME: - A better message on how to get started will help the user who is coming for the first time.
            AarKayLogger.logNoDatafiles(); return
        }
        
        do {
            /// Skip checking whether directory is dirty if force is set to true
            if !options.force {
                if try fileManager.git.isDirty(url: url) {
                    AarKayLogger.logDirtyRepo(); return
                }
            }
            
            /// The global context to be applied to all files being generated.
            let globalContext = try aarkayGlobalContext()
            
            /// First level of subdirectories in AarKayFiles directory are the names of the plugins.
            let urls = try fileManager.contentsOfDirectory(
                at: aarkayFilesUrl,
                includingPropertiesForKeys: [.isDirectoryKey],
                options: .skipsHiddenFiles
            )
            
            urls.forEach {
                let plugin = $0.lastPathComponent
                
                /// Create directory tree mirror with source as the AarKayFiles url and destination as the project url.
                let dirTreeMirror = DirTreeMirror(
                    sourceUrl: $0,
                    destinationUrl: url,
                    fileManager: fileManager
                )
                
                do {
                    try dirTreeMirror.bootstrap { ( sourceUrl: URL, destinationUrl: URL) in
                        /// Ignore the system dotfiles in AarKayFiles directory. Users can create custom dotfiles using string "dot" like 'dot.filename.yml' which will be generated as '.filename.ext'.
                        guard !sourceUrl.lastPathComponent.hasPrefix(".") else { return }
                        
                        AarKayLogger.logDatafile(at: sourceUrl)
                        
                        /// All Datafiles will have atleast two components seperated by ".".
                        /// The latter component will be the extension of type of serialization file like yml, json, exel and so on and the first component as the name of the template and the name of filename.
                        ///
                        /// For instance: -
                        ///     1. Template.yml
                        ///     2. gitignore.yml
                        ///     3. CoreData.json
                        ///
                        /// The template name and the file name in this cases is same and always the first component - Template, gitignore, CoreData.
                        ///
                        /// However Datafiles can also have 3 components seperated by ".".
                        ///
                        /// For instance: -
                        ///     1. Name.Template.yml
                        ///     2. swift.gitignore.yml
                        ///     3. DataModel.CoreData.json
                        ///
                        /// The template name in this case is the second component - Template, gitignore, CoreData and the filename will be the first component - Name, swift, DataModel.
                        ///
                        /// Return log error if the components are more than 3 or less than 2. A special case where components will be 4 is only when the first component is "dot" as the first "dot" is treated as actual ".".
                        let components = sourceUrl.lastPathComponent.components(separatedBy: ".")
                        if components.count < 2 ||
                            components.count > 4 ||
                            (components.count == 4 && components[0] != "dot") {
                            AarKayLogger.logErrorMessage("Invalid Datafile name at \(sourceUrl.lastPathComponent)")
                            return
                        }
                        
                        let name = components[0]
                        let template = components[components.count-2]
                        
                        do {
                            /// Read the contents of the Datafile.
                            let contents = try String(contentsOf: sourceUrl)
                            
                            /// Returns all rendered files result from the contents of Datafile.
                            let renderedfiles = try AarKayKit.bootstrap(plugin: plugin,
                                                                        globalContext: globalContext,
                                                                        fileName: name,
                                                                        template: template,
                                                                        contents: contents)
                            
                            try renderedfiles.forEach { renderedfile in
                                switch renderedfile {
                                case .success(let value):
                                    /// Create the file at the mirrored destination url with the generated contents.
                                    try createFile(
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
                } catch {
                    AarKayLogger.logError(error)
                }
            }
        } catch {
            AarKayLogger.logError(error)
        }
    }
    
    /// Reads the current file at url and merges the contents of `RenderedFile` to it.
    ///
    /// - Parameters:
    ///   - renderedfile: The rendered file.
    ///   - url: The destination url.
    /// - Throws: FileManager operation errors.
    func createFile(renderedfile: Renderedfile, at url: URL) throws {
        var url = url
        if let directory = renderedfile.directory {
            url = url
                .appendingPathComponent(directory, isDirectory: true)
                .standardized
        }
        url.appendPathComponent(renderedfile.fileName)
        let stringBlock = renderedfile.stringBlock
        let override = renderedfile.override
        if fileManager.fileExists(atPath: url.path) {
            if !override {
                if options.verbose {
                    AarKayLogger.logFileSkipped(at: url)
                }
            } else {
                let currentString = try String(contentsOf: url)
                let string = stringBlock(currentString)
                if string != currentString {
                    try string.write(toFile: url.path, atomically: true, encoding: .utf8)
                    AarKayLogger.logFileModified(at: url)
                } else {
                    if options.verbose {
                        AarKayLogger.logFileSkipped(at: url)
                    }
                }
            }
        } else {
            let string = stringBlock(nil)
            try fileManager.createDirectory(at: url.deletingLastPathComponent(), withIntermediateDirectories: true, attributes: nil)
            try string.write(toFile: url.path, atomically: true, encoding: .utf8)
            AarKayLogger.logFileAdded(at: url)
        }
    }
    
    /// Reads the global context url from the path "{PROJECT_ROOT}/AarKay/.aarkay".
    ///
    /// - Returns: The key value pairs from global context url.
    /// - Throws: An error if the context url is not readable.
    func aarkayGlobalContext() throws -> [String: Any]? {
        let aarkayGlobalContextUrl = url.appendingPathComponent("AarKay/.aarkay")
        guard let contents = try? String(contentsOf: aarkayGlobalContextUrl) else {
            return nil
        }
        return try YamlInputSerializer.load(contents) as? [String: Any]
    }
    
}
