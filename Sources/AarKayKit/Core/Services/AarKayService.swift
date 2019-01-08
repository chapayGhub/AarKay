//
//  AarKayService.swift
//  AarKayKit
//
//  Created by RahulKatariya on 20/10/18.
//

import Foundation

protocol AarKayService {
    var datafileService: DatafileService { get }
    var generatedfileService: GeneratedfileService { get }

    init(
        datafileService: DatafileService,
        generatedfileService: GeneratedfileService
    )
}

enum AarKayError: Error {
    case missingPlugin(String)
    case missingFileName(String, String, [String: Any])
    case modelDecodingFailure(String, String)
    case templateNotFound(String)
    case invalidTemplate(String)
}

extension AarKayError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .missingPlugin(let name):
            return "Couldn't find the plugin with the name \(name)"
        case .missingFileName(let plugin, let template, let context):
            return "Couldn't resolve filename in \(plugin).\(template) with \(context)"
        case .modelDecodingFailure(let name, let model):
            return "Couldn't decode \(model) for \(name)"
        case .templateNotFound(let name):
            return "\(name) could not be found"
        case .invalidTemplate(let name):
            return "\(name) components count should not be more than 3"
        }
    }
}
