//
//  AddUserViewController.swift
//  CloudFirestoreEasySample
//
//  Created by Kittisak Phetrungnapha on 10/6/17.
//  Copyright © 2017 itopstory. All rights reserved.
//

import UIKit
import FirebaseFirestore

final class AddUserViewController: UIViewController {
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var programmingSkillsTextField: UITextField!
    
    var selectedEngineer: User?
    
    // TODO: - Declare Cloud Firestore
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let selectedEngineer = selectedEngineer {
            navigationItem.leftBarButtonItem = nil
            navigationItem.title = selectedEngineer.firstName
            
            firstNameTextField.text = selectedEngineer.firstName
            lastNameTextField.text = selectedEngineer.lastName
            programmingSkillsTextField.text = selectedEngineer.skills.joined(separator: ", ")
        }
    }
    
    @IBAction func touchCancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func touchDone(_ sender: UIBarButtonItem) {
        guard let firstNameInput = firstNameTextField.text, !firstNameInput.isEmpty,
            let lastNameInput = lastNameTextField.text, !lastNameInput.isEmpty,
            let skillsInput = programmingSkillsTextField.text, !skillsInput.isEmpty else {
                return
        }
        
        
        if let selectedEngineer = selectedEngineer {
            // TODO: - Execute update instead of add
 
            return
        }
        
        // TODO: - Add a new engineer
    }
}
