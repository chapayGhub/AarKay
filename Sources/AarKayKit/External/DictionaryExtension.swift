//
//  DictionaryExtension.swift
//  AarKayKit
//
//  Created by Rahul Katariya on 28/02/18.
//

import Foundation

func + <T, U>(lhs: [T: U]?, rhs: [T: U]?) -> [T: U]? {
    guard let lhs = lhs else { return rhs }
    guard let rhs = rhs else { return lhs }

    var merged = lhs
    for (key, val) in rhs {
        merged[key] = val
    }

    return merged
}
