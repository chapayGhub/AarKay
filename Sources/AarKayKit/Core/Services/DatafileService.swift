//
//  DatafileService.swift
//  AarKay
//
//  Created by RahulKatariya on 20/10/18.
//

import Foundation
import Result

protocol DatafileService {
    
    func templateClass(
        plugin: String,
        template: String
    ) throws -> Templatable.Type
    
    func generatedfiles(
        datafile: Datafile,
        fileName: String?,
        contextArray: [[String: Any]],
        templateClass: Templatable.Type
    ) -> [Result<Generatedfile, AnyError>]
    
}
