//     _____                  ____  __.
//    /  _  \ _____ _______  |    |/ _|____  ___.__.
//   /  /_\  \\__  \\_  __ \ |      < \__  \<   |  |
//  /    |    \/ __ \|  | \/ |    |  \ / __ \\___  |
//  \____|__  (____  /__|    |____|__ (____  / ____|
//          \/     \/                \/    \/\/
//  

import Foundation
import AarKayKit

public class ArgModel: Codable {
    public var name: String
    public var type: String
    public var value: String?

    public var isOptional: Bool {
        /// <aarkay isOptional>
        return type.hasSuffix("?")
        /// </aarkay>
    }

    public var isWrapped: Bool {
        /// <aarkay isWrapped>
        return type.hasSuffix("!")
        /// </aarkay>
    }

    public var isOptionalOrWrapped: Bool {
        /// <aarkay isOptionalOrWrapped>
        return isOptional || isWrapped
        /// </aarkay>
    }

    public var isArray: Bool {
        /// <aarkay isArray>
        if swiftType.hasPrefix("[[") && swiftType.hasSuffix("]]") {
            return true
        } else if swiftType.hasPrefix("[") &&
            swiftType.hasSuffix("]") &&
            !swiftType.contains(":") {
            return true
        } else {
            return false
        }
        /// </aarkay>
    }

    public var swiftType: String {
        /// <aarkay swiftType>
        return isOptionalOrWrapped ? String(type.dropLast()) : type
        /// </aarkay>
    }

    private enum CodingKeys: String, CodingKey {
        case name
        case type
        case value
        case isOptional
        case isWrapped
        case isOptionalOrWrapped
        case isArray
        case swiftType
    }

    public init(name: String, type: String) {
        self.name = name
        self.type = type
    }

    public required init(from decoder: Decoder) throws {
        /// <aarkay decoder>
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        let names = ["name", "type", "value"]
        let types = ["String", "String", "String?"]
        let nameTypeValue = try NameTypeValue(names: names,
                                          types: types,
                                          value: string).toDictionary()
        self.name = nameTypeValue["name"] as! String
        self.type = nameTypeValue["type"] as! String
        self.value = nameTypeValue["value"] as? String
        /// </aarkay>
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(type, forKey: .type)
        try container.encodeIfPresent(value, forKey: .value)
        try container.encode(isOptional, forKey: .isOptional)
        try container.encode(isWrapped, forKey: .isWrapped)
        try container.encode(isOptionalOrWrapped, forKey: .isOptionalOrWrapped)
        try container.encode(isArray, forKey: .isArray)
        try container.encode(swiftType, forKey: .swiftType)
    }

}
