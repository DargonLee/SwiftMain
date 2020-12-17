//
//  User.swift
//  SwiftMain
//
//  Created by Harlan on 2019/1/11.
//  Copyright © 2019 Harlan. All rights reserved.
//

import Foundation

struct UserInfo {
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
