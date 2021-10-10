//
//  StringHelpers.swift
//  DLDFoundation
//
//  Created by Dionne Lie-Sam-Foek on 30/03/2021.
//  Copyright © 2021 DiLieDevs. All rights reserved.
//

import Foundation

public extension String {
    /// Returns the number of Unicode characters in the string.
    var length: Int {
        return count
    }
    /// Returns the range of the entire string.
    var range: Range<String.Index> {
        return range(of: self)!
    }
    /// Returns an uppercase representation of the string.
    var uppered: String {
        return uppercased()
    }
    /// Returns a lowercase representation of the string.
    var lowered: String {
        return lowercased()
    }
    /// Returns the string with only the first letter capitalized, like a sentence.
    var sentenced: String {
        return sentenceCased()
    }
    /// Returns a new string made by removing from both ends of the string characters contained in the whitespace character set (`space` and `tab`).
    var trimmed: String {
        return trimmingCharacters(in: .whitespaces)
    }
    /// Returns a new string made by removing from both ends of the string characters contained in the whitespace and newline character set (`space` and `tab` and newline characters).
    var lineTrimmed: String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    /// Returns an `NSString` object initialized by copying the characters from the string.
    var ns: NSString {
        return NSString(string: self)
    }
    /// Returns `true` if the string is a valid email address.
    var isEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return emailTest.evaluate(with: self)
    }
    
    // MARK: - Modifying Strings
    /// Returns a new string in which all occurrences of the target string are replaced by another given string.
    ///
    /// - parameter target:      The substring to replace.
    /// - parameter replacement: The string with which to replace `target`.
    ///
    /// - returns: A new string in which all occurrences of `target` in the string are replaced by `replacement`.
    func replacing(_ target: String, with replacement: String) -> String {
        return replacingOccurrences(of: target, with: replacement)
    }
    
    /// Returns a new string in which all occurrences of the specified target string have been removed, i.e. replaced with an empty string.
    ///
    /// - Parameter target: The substring to remove.
    /// - Returns: A new string in which all occurrences of `target` have been removed.
    func removing(_ target: String) -> String {
        return replacing(target, with: "")
    }
    
    /// /// Returns an array containing substrings from the string that have been divided by the given value conforming to the string protocol.
    /// - Parameter separator: The value conforming to the string protocol to use as the separator.
    func split<T: StringProtocol>(by separator: T) -> [String] {
        return components(separatedBy: separator)
    }
    
    /// Returns an array containing substrings from the string that have been divided by characters in the given set.
    /// - Parameter characterSet: The character set to use as the separator.
    func split(by characterSet: CharacterSet) -> [String] {
        return components(separatedBy: characterSet)
    }
    
    /// Returns a new string in which the value is repeated the specified number of times.
    ///
    /// - Parameter times: The number of times to repeat the string.
    /// - Returns: A new string in which the value is repeated the specified number of times.
    func repeated(times: Int) -> String {
        return String(repeating: self, count: times)
    }
    
    /// Returns a new string with the given prefix removed from the receiver.
    /// - Parameter prefix: The prefix string to remove.
    func removingPrefix(_ prefix: String) -> String {
        guard hasPrefix(prefix) else { return self }
        return String(dropFirst(prefix.count))
    }
    
    /// Returns a new string with the given suffix removed from the receiver.
    /// - Parameter suffix: The suffix to remove.
    func removingSuffix(_ suffix: String) -> String {
        guard hasSuffix(suffix) else { return self }
        return String(dropLast(suffix.count))
    }
    
    /// Returns a new string by prepending the given prefix to the receiver.
    /// - Parameter prefix: The prefix to prepend.
    func prefix(with prefix: String) -> String {
        guard !hasPrefix(prefix) else { return self }
        return prefix + self
    }
    
    /// Returns a new string by appending the given suffix to the receiver.
    /// - Parameter suffix: The suffix to append.
    func suffix(with suffix: String) -> String {
        guard !hasSuffix(suffix) else { return self }
        return self + suffix
    }
    
    private func sentenceCased() -> String {
        guard isNotEmpty, let first = first else { return self }
        
        return String(first).uppered + self.dropFirst()
    }
}

public extension String {
    /// An enumeration of cases representing the placement of a space in a string.
    enum SpacePlacement {
        /// Inserts a space before the receiving string.
        case before
        /// Inserts a space after the receiving string.
        case after
        /// Does nothing to the receiving string, leaving it as is.
        case none
    }
    
    /// Returns the receiving string with a space according to the given placement.
    /// - Parameter placement: The location of where the space should be placed.
    /// - Returns: A new string with a space at the specified location.
    func spaced(_ placement: SpacePlacement) -> String {
        switch placement {
        case .before : return prefix(with: " ")
        case .after  : return suffix(with: " ")
        case.none    : return self
        }
    }
}

public extension NSString {
    /// Returns the range of the entire string.
    var range: NSRange {
        return range(of: self as String)
    }
}
