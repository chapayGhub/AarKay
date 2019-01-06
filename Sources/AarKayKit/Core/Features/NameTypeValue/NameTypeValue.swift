//
//  NameTypeValue.swift
//  AarKayKit
//
//  Created by Rahul Katariya on 02/01/18.
//

import Foundation

public enum NameTypeValueError: Error {
    case invalidTransformation
}

public struct NameTypeValue {
    
    public let names: [String]
    public let types: [String]
    public let values: [String]
    
    public init(names: [String], types: [String], value: String) {
        self.names = names
        self.types = types
        self.values = value.components(separatedBy: "|")
    }
    
    public func toDictionary() throws -> [String: Any] {
        var dictionary: [String: Any] = [:]
        for (name, type, value) in zip(names, types, values) {
            if let value = TypeValueTransformer(type: type, value: value)?.value {
                dictionary[name] = value
            } else if !type.isOptionalType() {
                throw NameTypeValueError.invalidTransformation
            }
        }
        return dictionary
    }

}
