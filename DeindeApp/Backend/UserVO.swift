//
//  UserVO.swift
//  DeindeApp
//
//  Created by Andrey Krit on 7/22/17.
//  Copyright © 2017 Andrey Krit. All rights reserved.
//

import Foundation
import SwiftyJSON

struct UserVO {
    
    var token: String? // what comes from firebaase
    var id: Int?
    var name: String?
    //var firstName: String?
    //var secondName: String?
    var email: String?
    var facebook: String?
    var avatar: URL?
    var description: String?
    var userTours: [TripVO]?
    
    
    static let currentUser = UserVO()
    
    
}
