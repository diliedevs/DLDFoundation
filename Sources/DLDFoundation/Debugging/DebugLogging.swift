//
//  DebugLogging.swift
//  DLDFoundation
//
//  Created by Dionne Lie Sam Foek on 30/05/2026.
//  Copyright © 2026 DiLieDevs. All rights reserved.
//

import Foundation

func dbg(
    _ items: Any...,
    separator: String = " ",
    terminator: String = "\n",
    file: String = #file,
    function: String = #function,
    line: Int = #line
) {
    #if DEBUG
    let time = Date.now.formatted(date: .omitted, time: .standard)
    let fileName = URL(filePath: file).name
    let infoSeparator = items.count == 1 ? " → " : " →\n"
    let info = "[\(time)] \(fileName):\(line) \(function)"
    let itemDescs = items.map(String.init(describing:)).joined(separator: separator)
    
    print(info, itemDescs, separator: infoSeparator, terminator: terminator)
    #endif
}
