//
//  Renderedfile.swift
//  AarKayKit
//
//  Created by RahulKatariya on 24/08/18.
//

import Foundation

public struct Renderedfile {
    public let fileName: String
    public let directory: String?
    public let override: Bool
    public let stringBlock: (String?) -> String
    
    init(fileName: String,
         directory: String?,
         override: Bool,
         stringBlock: @escaping (String?) -> String
    ) {
        self.fileName = fileName
        self.directory = directory
        self.override = override
        self.stringBlock = stringBlock
    }
}
