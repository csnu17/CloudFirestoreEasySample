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
            let engineers = document.documents.flatMap { User(document: $0) }
            self?.engineers = engineers
            self?.tableView.reloadData()
        }
    }
    
    // TODO: - Remove listener
    deinit {
        listener?.remove()
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
        let editRowAction = UITableViewRowAction(style: .default, title: "Edit") { _, _  in
            
        }
        
        let deleteRowAction = UITableViewRowAction(style: .default, title: "Delete") { _, _  in
            
        }
        
        return [deleteRowAction, editRowAction];
    }
}

