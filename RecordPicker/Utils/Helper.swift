//
//  Helper.swift
//  RecordPicker
//
//  Created by Tiago Valente on 05/11/2018.
//  Copyright © 2018 Tiago Valente. All rights reserved.
//

import Foundation
import UIKit

let UsernameKey = "USERNAME_KEY"
let ReleasesKey = "RELEASES_KEY"

class Helper {

    class func saveUsername(_ username:String?){
        UserDefaults.standard.set(username, forKey: UsernameKey)
    }
    
    class func getUsername() -> String? {
        var username:String?
        if let defaultsUsername = UserDefaults.standard.string(forKey: UsernameKey) {
            username = defaultsUsername
        }
        return username
    }
    
    class func saveReleases(_ releases:Int?){
        UserDefaults.standard.set(releases, forKey: ReleasesKey)
    }
    
    class func getReleases() -> Int? {
        var releases:Int?
        if let defaultsReleases = UserDefaults.standard.object(forKey: ReleasesKey) as? Int {
            releases = defaultsReleases
        }
        return releases
    }
    
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
