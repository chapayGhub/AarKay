//
//  Version.swift
//  AarKayRunner
//
//  Created by RahulKatariya on 01/01/19.
//

import Commandant
import Foundation
import Result
import AarKayRunnerKit

/// Type that encapsulates the configuration and evaluation of the `version` subcommand.
public struct VersionCommand: CommandProtocol {
    public let verb = "version"
    public let function = "Display the current version of aarkay"
    
    public func run(_ options: NoOptions<AarKayError>) -> Result<(), AarKayError> {
        println(AarKayVersion)
        return .success(())
    }
}
