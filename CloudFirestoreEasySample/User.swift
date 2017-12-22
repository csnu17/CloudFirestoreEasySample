//
//  User.swift
//  CloudFirestoreEasySample
//
//  Created by Kittisak Phetrungnapha on 10/6/17.
//  Copyright © 2017 itopstory. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct User {
    let id: String
    let firstName: String
    let lastName: String
    let skills: [String]
    
    // TODO: - Create init? method from DocumentSnapshot
}
