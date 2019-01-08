//
//  AarKayGitExtensions.swift
//  AarKay
//
//  Created by RahulKatariya on 22/12/18.
//

import Foundation

/// Describes a provider of git extensions.
public protocol GitExtensionsProvider {}

extension GitExtensionsProvider {
    /// A proxy which hosts git extensions for `self`.
    public var git: Git<Self> {
        return Git(self)
    }

    /// A proxy which hosts static git extensions for the type of `self`.
    public static var git: Git<Self>.Type {
        return Git<Self>.self
    }
}

/// A proxy which hosts reactive extensions of `Base`.
public struct Git<Base> {
    /// The `Base` instance the extensions would be invoked with.
    public let base: Base

    /// Construct a proxy
    ///
    /// - parameters:
    ///   - base: The object to be proxied.
    fileprivate init(_ base: Base) {
        self.base = base
    }
}
