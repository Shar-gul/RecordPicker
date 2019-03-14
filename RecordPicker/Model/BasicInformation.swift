//
//  BasicInformation.swift
//  RecordPicker
//
//  Created by Tiago Valente on 30/10/2018.
//  Copyright © 2018 Tiago Valente. All rights reserved.
//

import Foundation

class BasicInformation : Decodable {
    
    var artists: [Artist]
    var coverImage : String
    var title : String
    
}
