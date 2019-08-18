//
//  Users.swift
//  ReminderFirebase
//
//  Created by Luc Nguyen on 8/15/19.
//  Copyright © 2019 Luc Nguyen. All rights reserved.
//

import Foundation
import RealmSwift

struct Users {
    var email = ""
//    @objc dynamic var password = ""
    var works = [Works]()
    
    init(email : String, works : [Works]) {
        self.email = email
//        self.password = password
        self.works = works
    }
}
