//
//  DatafileProvider.swift
//  AarKayKit
//
//  Created by RahulKatariya on 22/10/18.
//

import Foundation
import Result

class DatafileProvider: DatafileService {
    
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
        plugin: String,
        template: String,
        fileName: String?,
        contextArray: [[String: Any]],
        templateClass: Templatable.Type
    ) -> [Result<Generatedfile, AnyError>] {
        let files = contextArray.map { context in
            Result<Generatedfile, AnyError> {
                guard let fileName: String = fileName ?? context.rk.fileName() else {
                    throw AarKayError.missingFileName(plugin, template, context)
                }
                let generatedfile = Generatedfile(
                    plugin: plugin,
                    name: fileName.rk.standardized,
                    directory: context.rk.dirName(),
                    contents: context,
                    override: context.rk.override() ?? true,
                    template: template
                )
                return generatedfile
            }
        }
        return templateGeneratedfiles(generatedfiles: files, templateClass: templateClass)
    }
    
    func templateGeneratedfiles(
        generatedfiles: [Result<Generatedfile, AnyError>],
        templateClass: Templatable.Type
    ) -> [Result<Generatedfile, AnyError>] {
        return generatedfiles.reduce([Result<Generatedfile, AnyError>]()) { original, generatedfile in
            switch generatedfile {
            case .success(let value):
                let results = templateGeneratedfiles(generatedfile: value,
                                                     templateClass: templateClass)
                return original + results
            case .failure(let failure):
                return original + [.failure(failure)]
            }
        }
    }
    
    func templateGeneratedfiles(
        generatedfile: Generatedfile,
        templateClass: Templatable.Type
    ) -> [Result<Generatedfile, AnyError>] {
        do {
            if let templatable = try templateClass.init(generatedfile: generatedfile) {
                return templatable.generatedfiles().map { .success($0) }
            } else {
                let error = AarKayError.modelDecodingFailure(
                    generatedfile.name, generatedfile.template+"Model"
                )
                return [Result.failure(AnyError(error))]
            }
        } catch {
            return [Result.failure(AnyError(error))]
        }
    }

}
