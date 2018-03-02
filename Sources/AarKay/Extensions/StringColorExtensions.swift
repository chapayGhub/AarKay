//
//  StringColorExtensions.swift
//  AarKay
//
//  Created by RahulKatariya on 21/08/18.
//

import PrettyColors

typealias PrettyColor = PrettyColors.Color.Named.Color

extension PrettyColor {
    
    func colored(_ string: String) -> String {
        return Color.Wrap(foreground: self).wrap(string)
    }
    
}

extension String {
    
    var black: String { return PrettyColor.black.colored(self) }
    var red: String { return PrettyColor.red.colored(self) }
    var green: String { return PrettyColor.green.colored(self) }
    var yellow: String { return PrettyColor.yellow.colored(self) }
    var blue: String { return PrettyColor.blue.colored(self) }
    var magenta: String { return PrettyColor.magenta.colored(self) }
    var cyan: String { return PrettyColor.cyan.colored(self) }
    var white: String { return PrettyColor.white.colored(self) }
    
}
