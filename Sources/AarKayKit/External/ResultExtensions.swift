//
//  ResultExtensions.swift
//  AarKayKit
//
//  Created by RahulKatariya on 22/10/18.
//

import Foundation
import Result

extension Sequence where Self.Element: ResultProtocol, Self.Element.Error: ErrorConvertible {
    
    /// Returns the result of applying `transform` to `Success`es’ values, or wrapping thrown errors.
    public func tryMap<U>(_ transform: (Element.Value) throws -> U) -> [Result<U, Element.Error>] {
        return map { $0.result.tryMap(transform) }
    }
    
}
