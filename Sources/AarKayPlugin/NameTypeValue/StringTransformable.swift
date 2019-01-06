//
//  StringTransformable.swift
//  AarKayPlugin
//
//  Created by RahulKatariya on 13/08/18.
//

import Foundation

public protocol StringTransformable {
    static func transform(value: String) -> Self?
}

extension String: StringTransformable {
    public static func transform(value: String) -> String? {
        return value
    }
}

extension Bool: StringTransformable {
    public static func transform(value: String) -> Bool? {
        switch value {
        case "true", "yes", "1": return true
        case "false", "no", "0": return false
        default: return nil
        }
    }
}

extension Int: StringTransformable {
    public static func transform(value: String) -> Int? {
        return Int(value)
    }
}

extension Int16: StringTransformable {
    public static func transform(value: String) -> Int16? {
        return Int16(value)
    }
}

extension Int32: StringTransformable {
    public static func transform(value: String) -> Int32? {
        return Int32(value)
    }
}

extension Int64: StringTransformable {
    public static func transform(value: String) -> Int64? {
        return Int64(value)
    }
}

extension Float: StringTransformable {
    public static func transform(value: String) -> Float? {
        return Float(value)
    }
}

extension Double: StringTransformable {
    public static func transform(value: String) -> Double? {
        return Double(value)
    }
}
