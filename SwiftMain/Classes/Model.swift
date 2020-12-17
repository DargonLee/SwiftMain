//
//  Model.swift
//  SwiftMain
//
//  Created by Harlan on 2018/12/26.
//  Copyright © 2018 Harlan. All rights reserved.
//

import Foundation
import HandyJSON

struct HomeNewsTitle: HandyJSON {
    
    var tip_new: Int = 0
    var default_add: Int = 0
    var web_url: String = ""
    var concern_id: String = ""
    var icon_url: String = ""
    var flags: Int = 0
    var type: Int = 0
    var name: String = ""
    
    var selected: Bool = true
}

struct User {
    let name: String
    let message: String
    
    init?(data: Data) {
        guard let obj = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            return nil
        }
        guard let name = obj["name"] as? String else {
            return nil
        }
        guard let message = obj["message"] as? String else {
            return nil
        }
        
        self.name = name
        self.message = message
    }
}
