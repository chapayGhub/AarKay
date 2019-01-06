//
//  TypeValueTransformer.swift
//  AarKayPlugin
//
//  Created by RahulKatariya on 13/08/18.
//

import Foundation

public class TypeValueTransformer {
    
    private(set) static var transformers: [String: StringTransformable.Type] = [
        "String": String.self ,
        "Bool": Bool.self,
        "Int": Int.self,
        "Int16": Int16.self,
        "Int32": Int32.self,
        "Int64": Int64.self,
        "Float": Float.self,
        "Double": Double.self
    ]
    
    public static func register(transformer: StringTransformable.Type) {
        transformers[String(describing: transformer)] = transformer
    }
    
    let value: Any?
    
    init?(type: String, value: String) {
        let strippedType = type.isOptionalType() ? String(type.dropLast()) : type
        if let transformer = TypeValueTransformer.transformers[strippedType] {
            self.value = transformer.transform(value: value)
        } else {
            return nil
        }
    }
    
}

extension String {
    
    func isOptionalType() -> Bool {
        guard let lastChar = self.last else { return false }
        return (lastChar == "?" || lastChar == "!") ? true : false
    }
    
}
