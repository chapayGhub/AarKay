//
//  CodableExtensions.swift
//  AarKayKit
//
//  Created by Rahul Katariya on 03/01/18.
//

import Foundation

extension Dictionary where Iterator.Element == (key: String, value: Any) {
    public func decode<T: Codable>(type: T.Type) throws -> T {
        let decodedData = try JSONSerialization.data(withJSONObject: self)
        let model = try JSONDecoder().decode(type, from: decodedData) as T
        return model
    }

    public static func encode<T: Codable>(data: T?) throws -> [String: Any]? {
        guard let data = data else { return nil }
        let encodedData = try JSONEncoder().encode(data)
        let collection = try JSONSerialization.jsonObject(with: encodedData, options: .allowFragments)
        return collection as? [String: Any]
    }
}
