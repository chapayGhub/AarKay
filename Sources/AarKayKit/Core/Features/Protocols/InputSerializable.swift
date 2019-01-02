//
//  InputSerializable.swift
//  AarKayKit
//
//  Created by Rahul Katariya on 27/02/18.
//

import Foundation

public protocol InputSerializable {
    func context(contents: String) throws -> Any?
}
