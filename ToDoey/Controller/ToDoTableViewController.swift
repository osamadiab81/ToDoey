//
//  ToDoTableViewController.swift
//  ToDoey
//
//  Created by iMac on 14/02/2018.
//  Copyright © 2018 iMac. All rights reserved.
//

import UIKit
import CoreData
class ToDoTableViewController: UITableViewController {
    
    var  itemArray = [Item]()
    var selectedCategory: Category? {
        didSet{
            loadItems()
        }
    }

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
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
       saveItems()
       tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        // Add alert to UIBarButtonItem
        let alert = UIAlertController(title: "Add New To Do Item", message: "", preferredStyle: .alert)
        // Add action to UIAlertAction
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
           // What will happen when the user click add item button on UIalert add item to the array
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
            self.itemArray.append(newItem)
            self.saveItems()

        }
        // addTextField To Alert
        alert.addTextField { (alertTextFeild) in
            alertTextFeild.placeholder = "Create New item"
            textField = alertTextFeild
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems(){
        //self.defualts.setValue(self.itemArray, forKey: "ToDoListArray")
        do{
            try context.save()
        }catch{
            print(error.localizedDescription)
        }
        //Reload data in table view to c the new item
        self.tableView.reloadData()
    }
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil){
//        let request: NSFetchRequest<Item> = Item.fetchRequest()
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        if let addtionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, addtionalPredicate])
        }else{
            request.predicate = categoryPredicate
        }

        do {
           itemArray = try context.fetch(request)
        } catch  {
            print(error.localizedDescription)
        }
        tableView.reloadData()
    }
    
}
//MARK: SearchBar Method
extension ToDoTableViewController: UISearchBarDelegate{
    
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        loadItems(with: request, predicate: predicate)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()

            }
        }
    }
    
}
