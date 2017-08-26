//
//  ViewController.swift
//  CoreDatamain
//
//  Created by Brijesh Dubey on 26/08/17.
//  Copyright © 2017 Brijesh Dubey. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
      let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBOutlet weak var searchResult: UILabel!
    @IBOutlet weak var search: UITextField!
    @IBOutlet weak var secondName: UITextField!
    @IBOutlet weak var firstName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    // Before saving the data we have to check the first name and second name is empty or not.

    @IBAction func saveUser(_ sender: Any) {
        
        
        if firstName?.text != "" && secondName?.text != "" {
            
           //we are creating an variable as new user and save the firstName and secondName values in that.
            
            let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
            newUser.setValue(self.firstName!.text, forKey: "firstName")
            newUser.setValue(self.secondName!.text, forKey: "secondName")
            
            do {
                try context.save()
            } catch {
                print("error")
            }
            
        } else {
            print("Please fill the first and second name")
        }
        
        
        
        
        
    }
    
    // Searching the Data and showing that data in label.
    
    @IBAction func searchBtn(_ sender: Any) {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        let searchString = self.search?.text
        request.predicate = NSPredicate(format: "firstName == %@", searchString!)
        
        do {
            let result = try context.fetch(request)
            if result.count > 0 {
                
                let firstname = (result[0] as AnyObject).value(forKey: "firstName") as! String
                let secondname = (result[0] as AnyObject).value(forKey: "secondName") as! String
                
                self.searchResult?.text = firstname + " " + secondname
            }
            else {
                self.searchResult?.text = "no user"
            }
            
        } catch {
            print(error)
        }
    }

    
    

    @IBOutlet weak var searchbtn: UIButton!
}

