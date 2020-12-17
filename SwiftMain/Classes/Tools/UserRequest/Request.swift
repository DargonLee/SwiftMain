//
//  Request.swift
//  SwiftMain
//
//  Created by Harlan on 2019/1/12.
//  Copyright © 2019 Harlan. All rights reserved.
//

import UIKit

enum HTTPMethods: String {
    case GET
    case POST
}

protocol Request {
    var host: String { get }
    var path: String { get }
    
    var method: HTTPMethods { get }
    var parameter: [String: Any] { get }
    
    associatedtype Response: Decodable
}

struct UsersRequest: Request {
    
    let name: String
    
    let host = "https://api.onevcat.com"
    var path: String {
        return "/users/\(name)"
    }
    let method: HTTPMethods = .GET
    let parameter: [String : Any] = [:]
    
    typealias Response = User
}

protocol Decodable {
    static func parse(data: Data) -> Self?
}

extension User: Decodable {
    static func parse(data: Data) -> User? {
        return User(data: data)
    }
}

protocol Client {
    func send<T: Request>(_ r: T, hander: @escaping (T.Response?) -> Void)
    var host: String { get }
}

struct URLSessionClient: Client {
    
    static let shared = URLSessionClient()
    
    let host: String = "https://api.onevcat.com"
    
    func send<T>(_ r: T, hander: @escaping (T.Response?) -> Void) where T : Request {
        // 具体实现方法
        let url = URL(string: host.appending(r.path))!
        var request = URLRequest(url: url)
        request.httpMethod = r.method.rawValue
        
        let task = URLSession.shared.dataTask(with: request) { data, res, error in
            if let data = data, let res = T.Response.parse(data: data) {
                DispatchQueue.main.async { hander(res) }
            }else {
                DispatchQueue.main.async { hander(nil) }
            }
        }
        task.resume()
    }
}

class TestViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        URLSessionClient.shared.send(UsersRequest(name: "onevcat")) { (user) in
            if let user = user {
                print("\(user.message) +++ \(user.name)")
            }
        }
    }
}
