//
//  Releases.swift
//  RecordPicker
//
//  Created by Tiago Valente on 30/10/2018.
//  Copyright © 2018 Tiago Valente. All rights reserved.
//

import Foundation

class Releases : Decodable {
    
    var releases : [Release]
    
}

extension Releases {
    
    class func requestRelease(numberOfItems: Int, success: @escaping (_ success: Releases) -> Void, failure: @escaping (String) -> Void) {
        
        guard let urlComp = URLComponents(string: "https://api.discogs.com/users/Shar-gul/collection/folders/0/releases") else {
            failure("")
            return
        }
        
        let pageNumber = Int.random(in: 0...numberOfItems)
        
        let params = ["page":"\(pageNumber)",
                      "per_page":"1",
                      "token":"QWVipKXpaexZZIlsNMsKSnFTJkouJJkkDsUhiHaT"]
        
        WebConnection.requestURL(url: urlComp, parameters: params, success: { (response) in
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let releases = try decoder.decode(Releases.self, from: response as! Data)
                success(releases)
            } catch let jsonErr {
                print("Error", jsonErr)
            }
        }) { (error) in
            print(error)
        }
        
//        guard let url = URL(string: "https://api.discogs.com/users/Shar-gul/collection/folders/0/releases?page=54&per_page=1") else { return }
//
//        var request = URLRequest(url: url)
//        request.setValue("QWVipKXpaexZZIlsNMsKSnFTJkouJJkkDsUhiHaT", forHTTPHeaderField: "token")
//
//        WebConnection.requestURL(urlRequest:request, success: { (response) in
//            do {
//                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
//                let releases = try decoder.decode(Releases.self, from: response as! Data)
//                success(releases)
//            } catch let jsonErr {
//                print("Error", jsonErr)
//            }
//        }) { (error) in
//            print(error)
//        }
    }
    
}
