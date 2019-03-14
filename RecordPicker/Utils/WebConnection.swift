//
//  WebConnection.swift
//  RecordPicker
//
//  Created by Tiago Valente on 30/10/2018.
//  Copyright © 2018 Tiago Valente. All rights reserved.
//

import Foundation

class WebConnection {

    enum httpMethod : String {
        case get     = "GET"
        case post    = "POST"
        case put     = "PUT"
    }
    
    class func requestURL(url: URLComponents,
                          methodType: httpMethod = httpMethod.get,
                          parameters: [String:String] = [:],
                          success: @escaping (_ success: Any) -> Void,
                          failure: @escaping (String) -> Void) {
        
        var urlComponents = url
        if !parameters.isEmpty {
            var items = [URLQueryItem]()
            for (key,value) in parameters {
                items.append(URLQueryItem(name: key, value: value))
            }
            urlComponents.queryItems = items
        }
        
        var urlRequest = URLRequest(url: urlComponents.url!)
        urlRequest.httpMethod = methodType.rawValue
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                if let err = error {
                    failure("Failed to get data from url: \(err)")
                    return
                }
            }
            guard let data = data else { return }
            success(data)
        }).resume()
    }
}
