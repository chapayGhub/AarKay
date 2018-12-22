//
//  AarKayLogger.swift
//  AarKay
//
//  Created by RahulKatariya on 22/12/18.
//

import Foundation
import Willow
import PrettyColors
import SwiftyTextTable

class AarKayLogger {
    
    private static let group = DispatchGroup()
    private static let queue = DispatchQueue(label: "me.RahulKatariya.AarKay.outputQueue", qos: .utility)
    
    private static let `default`: Logger = {
        return Logger(
            logLevels: [.all],
            writers: [ConsoleWriter()],
            executionMethod: .asynchronous(queue: queue, group: group)
        )
    }()
    
    static func waitForCompletion() {
        group.wait()
    }
    
    static func logTable(url: URL, datafilesUrl: URL) {
        let column = TextTableColumn(header: "🚀 Launch---i--n--g--> " + url.path)
        var table = TextTable(columns: [column])
        table.addRow(values: ["🙏🏻 AarKayData-------> " + datafilesUrl.path])
        AarKayLogger.default.errorMessage { table.render().magenta }
    }
    
    static func logNoDatafiles() {
        AarKayLogger.default.errorMessage { "No datafiles found".red }
    }
    
    static func logDirtyRepo() {
        AarKayLogger.default.errorMessage {
            "🚫 Please discard or stash all your changes to git or try it inside an empty folder".red
        }
    }
    
    static func logError(_ error: Error) {
        AarKayLogger.default.errorMessage { "   <!> \(error.localizedDescription)".red }
    }
    
    static func logDatafile(at url: URL) {
        AarKayLogger.default.errorMessage { "<^> \(url.lastPathComponent)".blue }
    }
    
    static func logFileAdded(at url: URL) {
        AarKayLogger.default.eventMessage { "   <+> \(url.absoluteString)".green }
    }
    
    static func logFileModified(at url: URL) {
        AarKayLogger.default.eventMessage { "   <*> \(url.absoluteString)".yellow }
    }
    
    static func logFileSkipped(at url: URL) {
        AarKayLogger.default.eventMessage { "   <-> \(url.absoluteString)" }
    }
    
}
