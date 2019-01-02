//
//  AarKay+Dictionary.swift
//  AarKayKit
//
//  Created by RahulKatariya on 24/08/18.
//

import Foundation

extension Dictionary: AarKayExtensionsProvider where Key == String, Value == Any {}

extension AarKay where Base == Dictionary<String, Any> {
    
    func fileName() -> String? {
        return base["_fn"] as? String ?? base["name"] as? String
    }
    
    func dirName() -> String? {
        return base["_dn"] as? String
    }
    
    func override() -> Bool? {
        return base["_or"] as? Bool
    }
    
}
