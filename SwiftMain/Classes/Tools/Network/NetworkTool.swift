//
//  NetworkTool.swift
//  SwiftMain
//
//  Created by Harlan on 2018/12/26.
//  Copyright © 2018 Harlan. All rights reserved.
//

import Foundation

/// 服务器地址
private let BASE_URL = "http://39.98.72.10:8080/"


protocol NetworkToolProtocol {
    // MARK: 首页测试网络请求
    static func loadHomeNewsTitleData(completionHandler: @escaping(_ newsTitles: HomeNewsTitle) -> ())
    
    ///其他方法声明
}

extension NetworkToolProtocol {
    static func loadHomeNewsTitleData(completionHandler: @escaping(_ newsTitles: HomeNewsTitle) -> ()){
        let url = BASE_URL + "user/authInfo"
        let params = ["authType":"base"]
        
        NetworkRequest.shareInstance.post(urlString: url, parameters: params, success: { (response) in
            let obj = HomeNewsTitle.deserialize(from: response)
            completionHandler(obj!)
        }) { (error) in
            
        }
    }
    
    ///其他方法实现
}


struct NetworkTool: NetworkToolProtocol {
    
}
