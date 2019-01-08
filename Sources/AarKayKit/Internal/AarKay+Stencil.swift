//
//  AarKay+URL.swift
//  AarKayKit
//
//  Created by RahulKatariya on 29/08/18.
//

import Foundation
import PathKit
import Stencil
import StencilSwiftKit

extension URL: AarKayExtensionsProvider {}

extension AarKay where Base == URL {
    func environment() -> Environment {
        let directories = [base] + (FileManager.default.subDirectories(atUrl: base) ?? [])
        let paths = directories.map { Path($0.path) }
        let aarkayFilesLoader = FileSystemLoader(paths: paths)
        let ext = Extension()
        ext.registerStencilSwiftExtensions()
        let environment = Environment(
            loader: aarkayFilesLoader,
            extensions: [ext],
            templateClass: StencilSwiftTemplate.self
        )
        return environment
    }

    func template(url: URL) throws -> (String, String)? {
        let name = url.lastPathComponent
        let fc = name.components(separatedBy: ".")
        guard fc.count > 1 && fc.count <= 3 else { throw AarKayError.invalidTemplate(name) }
        let templateName = fc.joined(separator: ".")
        let ext = fc.count == 3 ? fc[1] : ""
        return (templateName, ext)
    }
}
