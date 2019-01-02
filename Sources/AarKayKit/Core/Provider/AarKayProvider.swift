//
//  DatafileProvider.swift
//  AarKayKit
//
//  Created by RahulKatariya on 28/08/18.
//

import Foundation
import Result

final class AarKayProvider: AarKayService {
    
    let datafileService: DatafileService
    let generatedfileService: GeneratedfileService
    
    init(
        datafileService: DatafileService,
        generatedfileService: GeneratedfileService
    ) {
        self.datafileService = datafileService
        self.generatedfileService = generatedfileService
    }
    
}
