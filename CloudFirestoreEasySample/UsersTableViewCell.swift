//
//  UsersTableViewCell.swift
//  CloudFirestoreEasySample
//
//  Created by Kittisak Phetrungnapha on 10/6/17.
//  Copyright © 2017 itopstory. All rights reserved.
//

import UIKit

final class UsersTableViewCell: UITableViewCell {
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var skillsLabel: UILabel!
    
    var engineer: User! {
        didSet {
            fullNameLabel.text = "\(engineer.firstName) \(engineer.lastName)"
            skillsLabel.text = "Skills: \(engineer.skills.joined(separator: ", "))"
        }
    }
}
