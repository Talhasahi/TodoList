//
//  ViewController.swift
//  TodoList
//
//  Created by Talha on 09/03/2020.
//  Copyright © 2020 Talha. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    // Store data on key value
    //  it load entire P list
    var defult = UserDefaults.standard
     //var itemArray = ["Find Milk","Buy Eggs","Destory  Demogorgon"]
     var itemArray = [Item]()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        if let   item = defult.array(forKey: "TodoListArray") as? [Item] {
               itemArray = item
               }
        var item0 = Item()
        item0.titel = "Milk"
        itemArray.append(item0)
        var item1 = Item()
        item1.titel = "Egg"
        itemArray.append(item1)
        print(itemArray)
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].titel
        if itemArray[indexPath.row].check == true {
            cell.accessoryType = .checkmark
        }
        else {
            cell.accessoryType = .none
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        //For deselection immediately
        tableView.deselectRow(at: indexPath, animated: true)
        itemArray[indexPath.row].check =  !itemArray[indexPath.row].check
        
        /*Above line do same as this pic of code Do
         if itemArray[indexPath.row].check == true {
            itemArray[indexPath.row].check = false
        }
        else {
            itemArray[indexPath.row].check = true
        }*/
        tableView.reloadData()
       
    }
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textfeild = UITextField()
        let alert = UIAlertController(title: "Add New Todoy Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            var item = Item()
            item.titel = textfeild.text!
            self.itemArray.append(item)
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

