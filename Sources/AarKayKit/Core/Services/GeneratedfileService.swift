//
//  GeneratedfileService.swift
//  AarKayKit
//
//  Created by RahulKatariya on 22/10/18.
//

import Foundation
import Result

protocol GeneratedfileService {
    func renderedFiles(
        url: URL,
        generatedfiles: [Result<Generatedfile, AnyError>],
        context: [String: Any]?
    ) -> [Result<Renderedfile, AnyError>]
}
