//     _____                  ____  __.
//    /  _  \ _____ _______  |    |/ _|____  ___.__.
//   /  /_\  \\__  \\_  __ \ |      < \__  \<   |  |
//  /    |    \/ __ \|  | \/ |    |  \ / __ \\___  |
//  \____|__  (____  /__|    |____|__ (____  / ____|
//          \/     \/                \/    \/\/
//

import AarKayKit
import Foundation

public class Template: NSObject, Templatable {
    private let datafile: Datafile
    private var model: TemplateModel
    public var generatedfile: Generatedfile

    public required init?(datafile: Datafile, generatedfile: Generatedfile) throws {
        guard let contents = generatedfile.contents else { return nil }
        self.datafile = datafile
        self.model = try contents.decode(type: TemplateModel.self)
        var generatedfile = generatedfile
        generatedfile.contents = try Dictionary.encode(data: model)
        self.generatedfile = generatedfile
    }

    public static func resource() -> String {
        return #file
    }
}

public class TemplateModel: Codable {
    public var name: String
    public var properties: [ArgModel]?
    public var computedProperties: [ArgModel]?

    public var allProperties: [ArgModel]? {
        /// <aarkay allProperties>
        /// your code goes here.
        /// </aarkay>
    }

    public var requiredProperties: [ArgModel]? {
        /// <aarkay requiredProperties>
        /// your code goes here.
        /// </aarkay>
    }

    private enum CodingKeys: String, CodingKey {
        case name
        case properties
        case computedProperties
        case allProperties
        case requiredProperties
    }

    public init(name: String) {
        self.name = name
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.properties = try container.decodeIfPresent([ArgModel].self, forKey: .properties)
        self.computedProperties = try container.decodeIfPresent([ArgModel].self, forKey: .computedProperties)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encodeIfPresent(properties, forKey: .properties)
        try container.encodeIfPresent(computedProperties, forKey: .computedProperties)
        try container.encodeIfPresent(allProperties, forKey: .allProperties)
        try container.encodeIfPresent(requiredProperties, forKey: .requiredProperties)
    }
}
