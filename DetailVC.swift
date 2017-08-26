//
//  DetailVC.swift
//  CoreDatamain
//
//  Created by Brijesh Dubey on 26/08/17.
//  Copyright © 2017 Brijesh Dubey. All rights reserved.
//

import UIKit
import CoreData

class DetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var userArr: [User] = []
    
    // This line is important to fetch data from App Delegate and show it in table view. We have to write the same line for saving, fetching, deleting and changing the data.
    
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        fetchData()
        tableView.reloadData()

        
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userArr.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let name = userArr[indexPath.row]
        print(name)
        cell.textLabel?.text = name.firstName! + " " + name.secondName!
        return cell
    }
    
    func fetchData() {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            userArr = try context.fetch(User.fetchRequest())
        } catch {
            print(error)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if editingStyle == .delete {
            let user = userArr[indexPath.row]
            context.delete(user)
           (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do {
                userArr = try context.fetch(User.fetchRequest())
            } catch {
                print(error)
            }
            
        }
        tableView.reloadData()
        
    }
    
    

  }
