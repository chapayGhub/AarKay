//
//  AarKayProvider.swift
//  AarKayKit
//
//  Created by RahulKatariya on 22/10/18.
//

import Foundation
import Result

class AarKayProvider: AarKayService {
    func templateClass(
        plugin: String,
        template: String
    ) throws -> Templatable.Type {
        if let templateClass = NSClassFromString("\(plugin).\(template)") as? Templatable.Type {
            return templateClass
        } else if let templateClass = NSClassFromString("aarkay_plugin_\(plugin.lowercased()).\(template)") as? Templatable.Type {
            return templateClass
        } else {
            throw AarKayError.missingPlugin(plugin + "." + template)
        }
    }

    func generatedfiles(
        datafile: Datafile,
        fileName: String?,
        contextArray: [[String: Any]],
        templateClass: Templatable.Type
    ) -> [Result<Generatedfile, AnyError>] {
        let files = contextArray.map { context in
            Result<Generatedfile, AnyError> {
                guard let fileName: String = fileName ?? context.rk.fileName() else {
                    throw AarKayError.missingFileName(datafile.plugin, datafile.template, context)
                }
                let generatedfile = Generatedfile(
                    plugin: datafile.plugin,
                    name: fileName.rk.standardized,
                    directory: context.rk.dirName(),
                    contents: context,
                    override: context.rk.override() ?? true,
                    template: datafile.template
                )
                return generatedfile
            }
        }
        return self.templateGeneratedfiles(
            datafile: datafile,
            generatedfiles: files,
            templateClass: templateClass
        )
    }

    func templateGeneratedfiles(
        datafile: Datafile,
        generatedfiles: [Result<Generatedfile, AnyError>],
        templateClass: Templatable.Type
    ) -> [Result<Generatedfile, AnyError>] {
        return generatedfiles.reduce([Result<Generatedfile, AnyError>]()) { original, generatedfile in
            switch generatedfile {
            case .success(let value):
                let results = templateGeneratedfiles(
                    datafile: datafile,
                    generatedfile: value,
                    templateClass: templateClass
                )
                return original + results
            case .failure(let failure):
                return original + [.failure(failure)]
            }
        }
    }

    func templateGeneratedfiles(
        datafile: Datafile,
        generatedfile: Generatedfile,
        templateClass: Templatable.Type
    ) -> [Result<Generatedfile, AnyError>] {
        do {
            if let templatable = try templateClass.init(
                datafile: datafile,
                generatedfile: generatedfile
            ) {
                return templatable.generatedfiles().map { .success($0) }
            } else {
                let error = AarKayError.modelDecodingFailure(
                    generatedfile.name, generatedfile.template + "Model"
                )
                return [Result.failure(AnyError(error))]
            }
        } catch {
            return [Result.failure(AnyError(error))]
        }
    }

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
