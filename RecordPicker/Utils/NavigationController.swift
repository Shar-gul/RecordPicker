//
//  NavigationController.swift
//  RecordPicker
//
//  Created by Tiago Valente on 08/11/2018.
//  Copyright © 2018 Tiago Valente. All rights reserved.
//

import Foundation
import UIKit

class NavigationController : UINavigationController {
    
    private static var privateDefaultShared: NavigationController?
    class func shared() -> NavigationController {
        guard let uwShared = privateDefaultShared else {
            privateDefaultShared = NavigationController.init()
            return privateDefaultShared!
        }
        return uwShared
    }
    
    func openPopUpView(action: ((Bool) -> Void)? = nil) {
        let vc = UserViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
    }
    
}
