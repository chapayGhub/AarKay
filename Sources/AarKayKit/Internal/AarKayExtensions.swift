//
//  AarKayExtensions.swift
//  AarKayKit
//
//  Created by RahulKatariya on 24/08/18.
//

import Foundation

/// Describes a provider of aarkay extensions.
///
/// - note: `AarKayExtensionsProvider` does not indicate whether a type is
///         reactive. It is intended for extensions to types that are not owned
///         by the module in order to avoid name collisions and return type
///         ambiguities.
protocol AarKayExtensionsProvider {}

extension AarKayExtensionsProvider {
    
    /// A proxy which hosts aarkay extensions for `self`.
    public var rk: AarKay<Self> {
        return AarKay(self)
    }
    
    /// A proxy which hosts static aarkay extensions for the type of `self`.
    public static var rk: AarKay<Self>.Type {
        return AarKay<Self>.self
    }
    
}

/// A proxy which hosts aarkay extensions of `Base`.
class AarKay<Base> {
    
    /// The `Base` instance the extensions would be invoked with.
    let base: Base
    
    /// Construct a proxy
    ///
    /// - parameters:
    ///   - base: The object to be proxied.
    fileprivate init(_ base: Base) {
        self.base = base
    }
    
}
