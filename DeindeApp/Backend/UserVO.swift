//
//  UserVO.swift
//  DeindeApp
//
//  Created by Andrey Krit on 7/22/17.
//  Copyright © 2017 Andrey Krit. All rights reserved.
//

import Foundation
//import Parse


struct UserVO {
    
    //var token: String? // what comes from firebaase
    var id: String?
    var firstName: String?
    var secondName: String?
    //var email: String?
    var facebook: URL?
    var telNumber: String?
    //var avatar: URL?
    var details: String?
    var avatar: PFFile?
    var activationCode: String?
    //var userTours: [TripVO]?
 
    
    
}
