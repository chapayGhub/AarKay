//
//  AarKayLogger.swift
//  AarKay
//
//  Created by RahulKatariya on 22/12/18.
//

import Foundation
import PrettyColors
import SwiftyTextTable
import Willow

/// A type that encapsulates all logging events of AarKay.
class AarKayLogger {
    /// The default logger.
    private static let `default`: Logger = {
        return Logger(
            logLevels: [.all],
            writers: [ConsoleWriter()],
            executionMethod: .asynchronous(
                queue: DispatchQueue(label: "me.RahulKatariya.AarKay.outputQueue", qos: .utility)
            )
        )
    }()
    
    /// Wait for all logs to be recorded to the writers.
    static func waitForCompletion() {
        AarKayLogger.default.waitForAllLogsCompletion()
    }
    
    /// Logs for location of project and its datafiles when the project is bootstrapped.
    ///
    /// - Parameters:
    ///   - url: The url of the `Project`.
    ///   - datafilesUrl: The url of the `Datafiles`.
    static func logTable(url: URL, datafilesUrl: URL) {
        let column = TextTableColumn(header: "🚀 Launch---i--n--g--> " + url.path)
        var table = TextTable(columns: [column])
        table.addRow(values: ["🙏🏻 AarKayData-------> " + datafilesUrl.path])
        AarKayLogger.default.errorMessage { table.render().magenta }
    }
    
    /// Logs for missing datafiles.
    static func logNoDatafiles() {
        AarKayLogger.default.errorMessage { "No datafiles found".red }
    }
    
    /// Logs for dirty directory.
    static func logDirtyRepo() {
        AarKayLogger.default.errorMessage {
            "🚫 Please discard or stash all your changes to git or try it inside an empty folder".red
        }
    }
    
    /// Logs for error.
    ///
    /// - Parameter error: The `Error` object.
    static func logError(_ error: Error) {
        AarKayLogger.default.errorMessage { "   <!> \(error.localizedDescription)".red }
    }
    
    /// Logs for error message.
    ///
    /// - Parameter message: The error message.
    static func logErrorMessage(_ message: String) {
        AarKayLogger.default.errorMessage { "   <!> \(message)".red }
    }
    
    /// Logs for `Datafile` location.
    ///
    /// - Parameter url: The url of the datafile.
    static func logDatafile(at url: URL) {
        AarKayLogger.default.errorMessage { "<^> \(url.lastPathComponent)".blue }
    }
    
    /// Logs for a file being created.
    ///
    /// - Parameter url: The url of the created file.
    static func logFileAdded(at url: URL) {
        AarKayLogger.default.eventMessage { "   <+> \(url.relativeString)".green }
    }
    
    /// Logs for a file being modified.
    ///
    /// - Parameter url: The url of the modified file.
    static func logFileModified(at url: URL) {
        AarKayLogger.default.eventMessage { "   <*> \(url.relativeString)".yellow }
    }
    
    /// Logs for a file not changed.
    ///
    /// - Parameter url: The url of the skipped file.
    static func logFileSkipped(at url: URL) {
        AarKayLogger.default.eventMessage { "   <-> \(url.absoluteString)" }
    }
}
