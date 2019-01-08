//
//  StringColorExtensions.swift
//  AarKay
//
//  Created by RahulKatariya on 21/08/18.
//

import PrettyColors

typealias PrettyColor = PrettyColors.Color.Named.Color

extension PrettyColor {
    /// Wraps the string with self color.
    ///
    /// - Parameter string: The string to color.
    /// - Returns: The colored string.
    func colored(_ string: String) -> String {
        return Color.Wrap(foreground: self).wrap(string)
    }
}

extension String {
    /// Wraps self with red color
    var red: String { return PrettyColor.red.colored(self) }

    /// Wraps self with green color
    var green: String { return PrettyColor.green.colored(self) }

    /// Wraps self with yellow color
    var yellow: String { return PrettyColor.yellow.colored(self) }

    /// Wraps self with blue color
    var blue: String { return PrettyColor.blue.colored(self) }

    /// Wraps self with magenta color
    var magenta: String { return PrettyColor.magenta.colored(self) }
}
