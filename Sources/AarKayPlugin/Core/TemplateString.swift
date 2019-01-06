//     _____                  ____  __.
//    /  _  \ _____ _______  |    |/ _|____  ___.__.
//   /  /_\  \\__  \\_  __ \ |      < \__  \<   |  |
//  /    |    \/ __ \|  | \/ |    |  \ / __ \\___  |
//  \____|__  (____  /__|    |____|__ (____  / ____|
//          \/     \/                \/    \/\/
//  

import Foundation
import AarKayKit

public class TemplateStringModel: Codable {
    public var ext: String
    public var suffix: String?
    public var string: String
    public var subString: String?

    private enum CodingKeys: String, CodingKey {
        case ext
        case suffix
        case string
        case subString
    }

    public init(ext: String, string: String) {
        self.ext = ext
        self.string = string
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.ext = try container.decode(String.self, forKey: .ext)
        self.suffix = try container.decodeIfPresent(String.self, forKey: .suffix)
        self.string = try container.decode(String.self, forKey: .string)
        self.subString = try container.decodeIfPresent(String.self, forKey: .subString)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(ext, forKey: .ext)
        try container.encodeIfPresent(suffix, forKey: .suffix)
        try container.encode(string, forKey: .string)
        try container.encodeIfPresent(subString, forKey: .subString)
    }

}
