//
//  Log.swift
//  SwiftMain
//
//  Created by Harlan on 2018/12/27.
//  Copyright © 2018 Harlan. All rights reserved.
//

import Foundation

// 控制是否启用日志打印
// 此处的DEBUG应该在target下 Build Settings 搜索 Other Swift Flags
// 设置Debug 添加 -D DEBUG，注意不要好Release一起添加
#if DEBUG
fileprivate let StarDebug = true
#else
fileprivate let StarDebug = false
#endif


fileprivate let InfoTitle = "Info"

fileprivate let DebugTitle = "Debug"

fileprivate let WarningTitle = "Warning"

fileprivate let ErrorTitle = "Error"

fileprivate let ImportantTitle = "Important - 如果发现该行日志，应该及时处理"

fileprivate let SuccessTitle = "Success"

fileprivate let FailureTitle = "Failure"

fileprivate let AssertTitle = "Assert"

fileprivate let FatalErrorTitle = "FatalError"

struct Logger {
    
    fileprivate static func print<T>(_ value: T, title: String, functionName: String, fileName: String, lineNumber: Int) {
        
        guard StarDebug else {
            // relese 不打印
            return
        }
        Swift.print("<\(current_time())> [\(title)][\((fileName as NSString).lastPathComponent):\(lineNumber)] \(value)")
    }
    
    static func info<T>(_ value: T, functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
        print(value, title: InfoTitle, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }
    
    static func debug<T>(_ value: T, functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
        print(value, title: DebugTitle, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }
    
    static func warning<T>(_ value: T, functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
        
        print(value, title: WarningTitle, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }
    
    static func error<T>(_ value: T, functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
        print(value, title: ErrorTitle, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }
    
    static func important<T>(_ value: T, functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
        print(value, title: ImportantTitle, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }
    
    fileprivate static func current_time() -> String {
        let bufferSize = 255
        var buffer = [Int8](repeating: 0, count: bufferSize)
        var rawtime = time(nil)
        let timeinfo = localtime(&rawtime)
        strftime(&buffer, 32, "%Y-%m-%d %H:%M:%S", timeinfo) // %B
        let datetime = String(cString: buffer, encoding: String.Encoding.utf8)
        //        free(buffer)
        return datetime!
    }
    
    static func star_back_trace(_ depth: UInt) -> String {
        
        
        Swift.print(Thread.callStackSymbols);
        
        return "";
    }
    
}

// MARK: - Resoponse
extension Logger {
    
    static func success<T>(_ value: T, functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
        print(value, title: SuccessTitle, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }
    
    static func failure<T>(_ value: T, functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
        print(value, title: FailureTitle, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }
}

// MARK: - Assert
extension Logger {
    
    static func assertionFailure(_ value: String, functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
        print(value, title: AssertTitle, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
        Swift.assertionFailure(value)
        
    }
    
    static func assert(_ flag: Bool, value:String, functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
        print(value, title: AssertTitle, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
        Swift.assert(flag)
    }
    
    static func fatalError(_ value: String, functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
        print(value, title: FatalErrorTitle, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
        Swift.fatalError(value)
    }
}
