//
//  NetworkRequest.swift
//  TodayNews
//
//  Created by Harlan on 2018/11/28.
//  Copyright © 2018 Harlan. All rights reserved.
//

import UIKit
import Alamofire
import PKHUD


private enum StatusCode: String {
    case success = "0000"
    case notLogin = "2000"
}


struct ResponseError: Error {
    var errorCode: String
    var message: String
    var localizedDescription: String {
        return "The error code is: \(errorCode) message is: \(message)"
    }
}


class NetworkRequest: NSObject  {
    
    //单利
    static let shareInstance = NetworkRequest()
    
    private let headers : HTTPHeaders = ["token":"99a28298dd77446f8bd12bbf96574ee9"];
    
    private var manager: Alamofire.SessionManager = {
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        return Alamofire.SessionManager(configuration: configuration)
        
    }()
    
    //定义block
    typealias ResponseSuccess = (_ json: [String : Any]) -> Void
    typealias ResponseFailure = (Error) -> Void

    private func request(method: HTTPMethod,
                         urlString: String,
                         parameters: [String : Any],
                         success:@escaping ResponseSuccess,
                         failure: @escaping ResponseFailure)
    {
        
        let newParams = ["data": parameters]
        Alamofire.request(urlString, method: method, parameters: newParams,encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                guard let dict = value as? [String: Any] else { return }
                guard let errMsg = dict["msg"] as? String else { return }
                guard let code = dict["code"] as? String else { return }
                
                if code == StatusCode.success.rawValue {
                    success(dict)
                }else if code == StatusCode.notLogin.rawValue {
                    print("退出登陆")
                }
                else {
                    guard let urlString = response.request!.url?.absoluteString else { return }
                    let error = ResponseError(errorCode: code, message: errMsg)
                    HUD.dimsBackground = false
                    HUD.flash(.label(errMsg), delay: 2.0)
                    print(urlString + " 【 \(error.message) 】 ")
                    failure(error)
                }
            case .failure(let error):
                //网络错误信息提示
                HUD.dimsBackground = false
                HUD.flash(.label("网络错误"), delay: 2.0)
                print((response.request!.url?.absoluteString)! + "\t******\terror:\r\(error)")
                failure(error)
            }
        }
    }

    
    //POST 方法
    public func post(urlString: String, parameters: [String : Any], success:@escaping ResponseSuccess, failure: @escaping ResponseFailure)
    {
        request(method: .post, urlString: urlString, parameters: parameters, success: { (result) in
            success(result)
        }) { (error) in
            failure(error)
        }
    }
    
    //GET 方法
    
    //POST 方法
    public func get(urlString: String, parameters: [String : Any], success:@escaping ResponseSuccess, failure: @escaping ResponseFailure)
    {
        request(method: .get, urlString: urlString, parameters: parameters, success: { (result) in
            success(result)
        }) { (error) in
            failure(error)
        }
    }
}
