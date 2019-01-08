//
//  AarKayError.swift
//  AarKayRunner
//
//  Created by RahulKatariya on 01/01/19.
//

import Foundation
import ReactiveTask

/// A type encapsulating all errors related to `AarKay` commands.
public enum AarKayError: Error {
    /// Represents bootstrapping errors related to file manager operations.
    case bootstap(Error)
    /// Represents error where init command is executed on a already existing project in the given path.
    case projectAlreadyExists(String)
    /// Represents error where command is executed without setting up the project in the given path.
    case missingProject(String)
    /// Represents AarKayFile parsing error
    case parsingError
    /// Represents task related error occuring to execution of commands.
    case taskError(TaskError)
}

// MARK: - CustomStringConvertible

extension AarKayError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .bootstap(let error):
            return "[ERROR] \(error.localizedDescription). Please report the issue at https://github.com/AarKay/AarKay."
        case .projectAlreadyExists(let path):
            return "Project already exists at \(path). Use `--force` to start over."
        case .missingProject(let path):
            return "AarKay is not yet setup at \(path). Use `aarkay init [--global]` to setup."
        case .parsingError:
            return "Error parsing AarKayFile"
        case .taskError(let error):
            return error.description
        }
    }
}
