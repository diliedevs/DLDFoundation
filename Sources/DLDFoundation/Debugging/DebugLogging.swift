//
//  DebugLogging.swift
//  DLDFoundation
//
//  Created by Dionne Lie Sam Foek on 30/05/2026.
//  Copyright © 2026 DiLieDevs. All rights reserved.
//

import Foundation

func debugLog(_ message: Any, file: String = #file, function: String = #function, line: Int = #line) {
    #if DEBUG
    let fileName = URL(filePath: file).name
    let info = "\(fileName).\(function)[\(line)]"
    print("🔍 \(info) -> \(message)")
    #endif
}
