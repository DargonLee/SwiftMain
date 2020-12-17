//
//  UserDefaultTool.swift
//  SwiftMain
//
//  Created by Harlan on 2019/1/25.
//  Copyright © 2019 Harlan. All rights reserved.
//

import Foundation

protocol UserDefaultKeyNames {}
extension UserDefaultKeyNames
{
    static func keyNames<T>(_ key: T) -> String where T: RawRepresentable
    {
        return "\(Self.self).\(key.rawValue)"
    }
}

protocol UserDefaultStore: UserDefaultKeyNames {
    associatedtype UserDefaultKey: RawRepresentable
}
extension UserDefaultStore where UserDefaultKey.RawValue == String {}

extension UserDefaultStore
{
    static func remove(forKey key: UserDefaultKey)
    {
        UserDefaults.standard.removeObject(forKey: key as! String)
    }
    
    /// 关于 Int 类型存储和读取
    static func store(value: Int, forKey key: UserDefaultKey)
    {
        let key = keyNames(key)
        UserDefaults.standard.set(value, forKey: key)
    }
    static func storedInt(forKey key: UserDefaultKey) -> Int
    {
        let key = keyNames(key)
        
        return UserDefaults.standard.integer(forKey: key)
    }
    
    /// 关于 Bool 类型存储和读取
    static func store(value: Bool, forKey key: UserDefaultKey)
    {
        let key = keyNames(key)
        UserDefaults.standard.set(value, forKey: key)
    }
    static func storedBool(forKey key: UserDefaultKey) -> Bool
    {
        let key = keyNames(key)
        return UserDefaults.standard.bool(forKey: key)
    }
    
     /// 关于 String 类型存储和读取
    static func store(value: Any?, forKey key: UserDefaultKey)
    {
        let key = keyNames(key)
        UserDefaults.standard.set(value, forKey: key)
    }
    static func storedString(forKey key: UserDefaultKey) -> String?
    {
        let key = keyNames(key)
        return UserDefaults.standard.string(forKey: key)
    }
}

extension UserDefaults
{
    /// 账号信息
    struct Account: UserDefaultStore {
        enum UserDefaultKey: String {
            case token
            case name
            case phone
        }
    }
    
    /// 登陆信息
    struct LoginStatus: UserDefaultStore {
        enum UserDefaultKey: String {
            case isLogined
            case isFirstLogin
        }
    }
}
func xx() {
    UserDefaults.Account.store(value: 1, forKey: .name)
    _ = UserDefaults.Account.storedString(forKey: .name)
}
