//
//  Users.swift
//  ReminderFirebase
//
//  Created by Luc Nguyen on 8/15/19.
//  Copyright © 2019 Luc Nguyen. All rights reserved.
//

import Foundation
import RealmSwift

class Users : Object {
    @objc dynamic var username = ""
//    @objc dynamic var password = ""
    @objc dynamic var works = [Works]()
    
    convenience init(username : String) {
        self.init()
        self.username = username
//        self.password = password
    }
}
