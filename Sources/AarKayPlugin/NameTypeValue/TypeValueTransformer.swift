//
//  TypeValueTransformer.swift
//  AarKayPlugin
//
//  Created by RahulKatariya on 13/08/18.
//

import Foundation

class TypeValueTransformer {
    
    private(set) static var transformers: [String: TypeValueTransformable.Type] = [
        "String": String.self ,
        "Bool": Bool.self,
        "Int": Int.self,
        "Float": Float.self,
        "Double": Double.self
    ]
    
    public static func register(transformer: TypeValueTransformable.Type) {
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
