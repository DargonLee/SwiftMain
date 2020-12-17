//
//  NextPageState.swift
//  SwiftMain
//
//  Created by Harlan on 2019/1/16.
//  Copyright © 2019 Harlan. All rights reserved.
//

import Foundation

struct NextPageState<T> {
    private(set) var hasNext: Bool
    var isLoading: Bool
    private(set) var lastId: T?
    
    init() {
        hasNext = true
        isLoading = false
        lastId = nil
    }
    
    mutating func reset() {
        hasNext = true
        isLoading = false
        lastId = nil
    }
    
    mutating func update(hasNext: Bool, isLoading: Bool, lastId: T?) {
        self.hasNext = hasNext
        self.isLoading = isLoading
        self.lastId = lastId
    }
}

protocol NextPageLoadable: class {
    associatedtype DataType
    associatedtype LastIdType
    
    var data: [DataType] { get set }
    var nextPageState: NextPageState<LastIdType> { get set }
    func performLoad(successHander:(_ rows: [DataType], _ hasNext: Bool, _ lastId: LastIdType?) -> (),
                     failHandler: () -> ())
}

protocol ReloadableType {
    func reloadData()
}
