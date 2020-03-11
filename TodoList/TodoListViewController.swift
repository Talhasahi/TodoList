//
//  ViewController.swift
//  TodoList
//
//  Created by Talha on 09/03/2020.
//  Copyright © 2020 Talha. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
  
 //Create Own Plist For Store data
     let datFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("item.Plist")
     var itemArray = [Item]()
    override func viewDidLoad() {
        super.viewDidLoad()
       
       loaditem()
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
            var encode = PropertyListEncoder()
            do{
                let data = try encode.encode(self.itemArray)
                try data.write(to : self.datFilePath!)        }
        catch {
            print("Error Encoding")
        }
            self.tableView.reloadData()
        }
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create A new Item"
            textfeild = alertTextField
        }
        present(alert,animated: true,completion: nil)
    }
    func loaditem(){
        if  let data = try? Data(contentsOf: datFilePath!) {
            let decder = PropertyListDecoder()
            do{
            itemArray = try decder.decode([Item].self, from: data)
            }
            catch {
                print(error)
            }
        }
        }
        
    
}

