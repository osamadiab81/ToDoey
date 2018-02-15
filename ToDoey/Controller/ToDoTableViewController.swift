//
//  ToDoTableViewController.swift
//  ToDoey
//
//  Created by iMac on 14/02/2018.
//  Copyright © 2018 iMac. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController {
    
    var  itemArray = [Item]()
    let defualts = UserDefaults.standard

    override func viewDidLoad() {
        let newItem = Item()
        newItem.title = "osama"
        itemArray.append(newItem)
        
        super.viewDidLoad()
//        itemArray = defualts.array(forKey: "ToDoListArray") as! [Item]
    }


    // Returens Number of Rows (Array count)
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemArray.count
    }

    //Asks the data source for a cell to insert in a particular location of the table view.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // reusable cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        // Add Text to label of the cell
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done == true ?  .checkmark : .none
            return cell
    }
    
    
    // Tells the delegate that the specified row is now selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
       itemArray[indexPath.row].done = !itemArray[indexPath.row].done
       tableView.reloadData()
       tableView.deselectRow(at: indexPath, animated: true)

        
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        // Add alert to UIBarButtonItem
        let alert = UIAlertController(title: "Add New To Do Item", message: "", preferredStyle: .alert)
        // Add action to UIAlertAction
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
           // What will happen when the user click add item button on UIalert add item to the array
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            self.defualts.setValue(self.itemArray, forKey: "ToDoListArray")
            //Reload data in table view to c the new item
            self.tableView.reloadData()
        }
        // addTextField To Alert
        alert.addTextField { (alertTextFeild) in
            alertTextFeild.placeholder = "Create New item"
            textField = alertTextFeild
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

}