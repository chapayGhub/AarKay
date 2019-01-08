//
//  AarKayOptions.swift
//  AarKay
//
//  Created by RahulKatariya on 01/01/19.
//

import Foundation

/// A type that encapsulates the options for `AarKay`.
public struct AarKayOptions {
    /// The force flag.
    let force: Bool

    /// The verbose flag.
    let verbose: Bool

    /// Initializes `AarKayOptions`
    ///
    /// - Parameters:
    ///   - force: The force flag when set to false will not overwrite your files with the generated files if the directory is dirty. It ensures that the directory is empty or it's a clean git repository. `false` by default.
    ///   - verbose: The flag to print verbose logging to console. `false` by default.
    ///
    /// - note: Setting force to true in your production project is not recommended as it may lead to loss of exisiting work.
    public init(
        force: Bool = false,
        verbose: Bool = false
    ) {
        self.force = force
        self.verbose = verbose
    }
}
