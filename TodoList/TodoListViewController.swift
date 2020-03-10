//
//  ViewController.swift
//  TodoList
//
//  Created by Talha on 09/03/2020.
//  Copyright © 2020 Talha. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    //data base Store data on key value peera
    var defult = UserDefaults.standard
     var itemArray = ["Find Milk","Buy Eggs","Destory  Demogorgon"]

    override func viewDidLoad() {
        super.viewDidLoad()
        if let   item = defult.array(forKey: "TodoListArray") as? [String] {
            itemArray = item
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        //For deselection immediately
        tableView.deselectRow(at: indexPath, animated: true)
       
        if  tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else{
             tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textfeild = UITextField()
        let alert = UIAlertController(title: "Add New Todoy Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            self.itemArray.append(textfeild.text!)
            self.defult.set(self.itemArray, forKey: "TodoListArray")
            self.tableView.reloadData()
        }
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create A new Item"
            textfeild = alertTextField
            
        }
        present(alert,animated: true,completion: nil)
    }
}

