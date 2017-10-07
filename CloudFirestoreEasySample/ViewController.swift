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
    private lazy var defaultStore = Firestore.firestore()
    
    // TODO: - Declare listener
    private var listener: FIRListenerRegistration?
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView(frame: .zero)
            tableView.register(UINib(nibName: "UsersTableViewCell", bundle: nil), forCellReuseIdentifier: "UsersTableViewCell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        
        // TODO: - Add Cloud Firestore listener
        listener = defaultStore.collection("engineers").addSnapshotListener { [weak self] documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            
            // TODO: - Decode data to struct, update dataSource then reload tableView
            let engineers = document.documents.map { doc -> User? in
                var engineer = User(document: doc)
                engineer?.id = doc.documentID
                return engineer
                }.flatMap { $0 }
            
            self?.engineers = engineers
            self?.tableView.reloadData()
        }
    }
    
    // TODO: - Remove listener
    deinit {
        listener?.remove()
    }
    
    // TODO: - Prepare for edit user page
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
        let selectedEngineer = engineers[indexPath.row]
        
        let editRowAction = UITableViewRowAction(style: .default, title: "Edit") { _, _  in
            // TODO: - Send data to update page (add page but reuse it)
            self.performSegue(withIdentifier: "showEditUser", sender: selectedEngineer)
        }
        
        let deleteRowAction = UITableViewRowAction(style: .default, title: "Delete") { _, _  in
            // TODO: - Delete engineer (document)
            self.defaultStore.collection("engineers").document("\(selectedEngineer.id!)").delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                }
            }
        }
        
        return [deleteRowAction, editRowAction];
    }
}

