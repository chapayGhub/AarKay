//
//  AarKayKit.swift
//  AarKayKit
//
//  Created by Rahul Katariya on 04/12/17.
//

import Foundation
import Result

public class AarKayKit {
    
    let datafile: Datafile
    let aarkayService: AarKayService
    
    init(
        datafile: Datafile,
        aarkayService: AarKayService
    ) {
        self.datafile = datafile
        self.aarkayService = aarkayService
    }
    
}

extension AarKayKit {
    
    public static func bootstrap(
        plugin: String,
        globalContext: [String: Any]?,
        fileName: String,
        directory: String,
        template: String,
        contents: String
    ) throws -> [Result<Renderedfile, AnyError>] {
        
        let datafile = Datafile(
            plugin: plugin,
            name: fileName,
            directory: directory,
            template: template,
            contents: contents,
            globalContext: globalContext
        )
 
        let datafileService: DatafileService = DatafileProvider()
        let generatedfileService: GeneratedfileService = GeneratedfileProvider()
        let aarkayService: AarKayService = AarKayProvider(
            datafileService: datafileService,
            generatedfileService: generatedfileService
        )
        
        let aarkayKit = AarKayKit(
            datafile: datafile,
            aarkayService: aarkayService
        )
        
        return try aarkayKit.bootstrap()
    }
    
}

extension AarKayKit {
    
    func bootstrap() throws -> [Result<Renderedfile, AnyError>] {
        
        // 1.
        var templateClass: Templatable.Type!
        var context: Any?
        do {
            templateClass = try aarkayService.datafileService.templateClass(
                plugin: datafile.plugin,
                template: datafile.template
            )
            context = try templateClass
                .inputSerializer()
                .context(contents: datafile.contents)
        } catch {
            throw AnyError(error)
        }
        
        // 2.
        var fileName: String?
        var contextArray: [[String: Any]]
        if datafile.name.rk.isCollection {
            fileName = nil
            contextArray = context as? [[String: Any]] ?? [[:]]
        } else {
            fileName = datafile.name
            contextArray = [context] as? [[String: Any]] ?? [[:]]
        }
        
        // 3.
        let generatedFiles = aarkayService.datafileService.generatedfiles(
            datafile: datafile,
            fileName: fileName,
            contextArray: contextArray,
            templateClass: templateClass
        )
        
        // 4.
        return aarkayService.generatedfileService.renderedFiles(
            url: templateClass.resource().rk.templatesDirectory(),
            generatedfiles: generatedFiles,
            context: datafile.globalContext
        )
    }
    
}
