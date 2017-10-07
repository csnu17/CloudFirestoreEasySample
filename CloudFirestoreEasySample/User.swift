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
    var id: String?
    let firstName: String
    let lastName: String
    let skills: [String]
    
    // TODO: - Create init helper method for document
    init?(document: DocumentSnapshot) {
        let data = document.data()
        guard let firstName = data["firstName"] as? String,
            let lastName = data["lastName"] as? String,
            let skills = data["skills"] as? [String] else {
                return nil
        }
        
        self.firstName = firstName
        self.lastName = lastName
        self.skills = skills
    }
}
