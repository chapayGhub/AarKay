//
//  TypeValueTransformable.swift
//  AarKayPlugin
//
//  Created by RahulKatariya on 13/08/18.
//

import Foundation

public protocol TypeValueTransformable {
    static func transform(value: String) -> Self?
}

extension String: TypeValueTransformable {
    public static func transform(value: String) -> String? {
        return value
    }
}

extension Bool: TypeValueTransformable {
    public static func transform(value: String) -> Bool? {
        switch value {
        case "true", "yes", "1": return true
        case "false", "no", "0": return false
        default: return nil
        }
    }
}

extension Int: TypeValueTransformable {
    public static func transform(value: String) -> Int? {
        return Int(value)
    }
}

extension Float: TypeValueTransformable {
    public static func transform(value: String) -> Float? {
        return Float(value)
    }
}

extension Double: TypeValueTransformable {
    public static func transform(value: String) -> Double? {
        return Double(value)
    }
}
