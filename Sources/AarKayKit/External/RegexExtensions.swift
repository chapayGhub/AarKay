//
//  RegexExtensions.swift
//  AarKayKit
//
//  Created by Rahul Katariya on 29/03/18.
//

import Foundation

extension String {
    
    func capturedGroups(withRegex pattern: String) -> [[Range<String.Index>]]? {
        var regex: NSRegularExpression
        do {
            regex = try NSRegularExpression(pattern: pattern, options: [])
        } catch {
            return nil
        }
        
        let matches = regex.matches(in: self, options: [], range: NSRange(location:0, length: self.count))
        guard matches.count > 0 else { return nil }
        var results = [[Range<String.Index>]]()
        matches.forEach {
            var groups = [Range<String.Index>]()
            let lastRangeIndex = $0.numberOfRanges - 1
            guard lastRangeIndex >= 1 else { return }
            for i in 1...lastRangeIndex {
                let capturedGroupIndex = Range($0.range(at: i), in: self)!
                groups.append(capturedGroupIndex)
            }
            results.append(groups)
        }
        return results
    }
    
}
