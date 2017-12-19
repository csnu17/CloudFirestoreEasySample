//
//  ViewController.swift
//  CloudFirestoreEasySample
//
//  Created by Kittisak Phetrungnapha on 10/6/17.
//  Copyright © 2017 itopstory. All rights reserved.
//

import UIKit
import FirebaseFirestore

final class ViewController: UIViewController {
    private var engineers: [User] = []
    
    // TODO: - Declare Cloud Firestore
    
    // TODO: - Declare listener
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(UINib(nibName: "UsersTableViewCell", bundle: nil), forCellReuseIdentifier: "UsersTableViewCell")
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        
        // TODO: - Add Cloud Firestore listener
    }
    
    
    deinit {
        // TODO: - Remove listener
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEditUser" {
            if let selectedEngineer = sender as? User {
                let destinationVC = segue.destination as! AddUserViewController
                destinationVC.selectedEngineer = selectedEngineer
            }
        }
    }
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showAddUsers", sender: nil)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return engineers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UsersTableViewCell", for: indexPath) as! UsersTableViewCell
        cell.engineer = engineers[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        // TODO: - Get selected engineer from index
        
        let editRowAction = UITableViewRowAction(style: .default, title: "Edit") { _, _  in
            // TODO: - Send data to update page (add page but reuse it)
        }
        
        let deleteRowAction = UITableViewRowAction(style: .default, title: "Delete") { _, _  in
            // TODO: - Delete engineer (document)
        }
        
        return [deleteRowAction, editRowAction]
    }
}

