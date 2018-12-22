//
//  AarKayExtensions.swift
//  AarKay
//
//  Created by RahulKatariya on 21/08/18.
//

import Foundation

extension URL {
    
    public static var aarkayRootDirectoryForCurrentUser: URL {
        return URL.init(fileURLWithPath: NSHomeDirectory())
    }
    
    public static var aarkayDirectoryForCurrentUser: URL {
        return aarkayRootDirectoryForCurrentUser
            .appendingPathComponent("AarKay")
    }
    
    public static var aarkayDataDirectoryForCurrentUser: URL {
        return aarkayDirectoryForCurrentUser
            .appendingPathComponent("AarKayData")
    }
    
}

