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
            let strippedType = isOptional(type: type) ? String(type.dropLast()) : type
            if let value = TypeValueTransformer(type: strippedType, value: value)?.value {
                dictionary[name] = value
            } else if !isOptional(type: type) {
                throw NameTypeValueError.invalidTransformation
            }
        }
        return dictionary
    }
    
    func isOptional(type: String) -> Bool {
        guard let lastChar = type.last else { return false }
        return (lastChar == "?" || lastChar == "!") ? true : false
    }
    

}
