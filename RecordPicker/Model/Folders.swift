//
//  Folders.swift
//  RecordPicker
//
//  Created by Tiago Valente on 30/10/2018.
//  Copyright © 2018 Tiago Valente. All rights reserved.
//

import Foundation

class Folders : Decodable {
    var folders : [Folder]
}

extension Folders {
    
    class func requestFolder(success: @escaping (_ success: Folders) -> Void, failure: @escaping (String) -> Void) {
        
        guard let urlComp = URLComponents(string: "https://api.discogs.com/users/Shar-gul/collection/folders") else {
            failure("")
            return
        }
        
        WebConnection.requestURL(url: urlComp, success: { (response) in
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let folders = try decoder.decode(Folders.self, from: response as! Data)
                success(folders)
            } catch let jsonErr {
                print("Error", jsonErr)
                failure("Error \(jsonErr)")
            }
        }) { (error) in
            print(error)
        }
    }
    
}
