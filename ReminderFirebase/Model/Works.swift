//
//  Works.swift
//  ReminderFirebase
//
//  Created by Luc Nguyen on 8/15/19.
//  Copyright © 2019 Luc Nguyen. All rights reserved.
//

import Foundation
import RealmSwift

class Works : Object {
    @objc dynamic var title = ""
    @objc dynamic var time = 0
    @objc dynamic var subWorks = [SubWorks]()

    convenience init(title : String, time : Int) {
        self.init()
        self.title = title
        self.time = time
    }
}
