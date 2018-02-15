//
//  ToDoTableViewController.swift
//  ToDoey
//
//  Created by iMac on 14/02/2018.
//  Copyright © 2018 iMac. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController {
    
    var  itemArray = ["Osama", "mohammed", "wael", "hassan"]
    let defualts = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        try! itemArray = defualts.array(forKey: "ToDoListArray") as! [String]

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    
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
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    
    // Tells the delegate that the specified row is now selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if (tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark){
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
    }

    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        // Add alert to UIBarButtonItem
        let alert = UIAlertController(title: "Add New To Do Item", message: "", preferredStyle: .alert)
        // Add action to UIAlertAction
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
           // What will happen when the user click add item button on UIalert add item to the array
            self.itemArray.append(textField.text!)
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
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
