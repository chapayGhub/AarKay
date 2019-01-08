//
//  GeneratedfileProvider.swift
//  AarKayKit
//
//  Created by RahulKatariya on 22/10/18.
//

import Foundation
import Result

class GeneratedfileProvider: GeneratedfileService {
    func renderedFiles(
        url: URL,
        generatedfiles: [Result<Generatedfile, AnyError>],
        context: [String: Any]?
    ) -> [Result<Renderedfile, AnyError>] {
        let renderedFiles: [Result<Renderedfile, AnyError>] = generatedfiles.tryMap {
            return try AarKayTemplates.default.render(
                url: url, generatedfile: $0, context: context
            )
        }
        return renderedFiles
    }
}
