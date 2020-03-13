//
//  ViewController.swift
//  TodoList
//
//  Created by Talha on 09/03/2020.
//  Copyright © 2020 Talha. All rights reserved.
import UIKit
import RealmSwift
class TodoListViewController: UITableViewController {
    let realm = try! Realm()
    @IBOutlet weak var searchBar: UISearchBar!
    var itemArray : Results <Item>?
    var  selectedCategory : Categories?{
        didSet{
            loaditem()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    } 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemArray?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoItemCell", for: indexPath)
        if let item = itemArray?[indexPath.row]{
              cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
        }
        else {
            cell.textLabel?.text = "No item Add"
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let thisItem = itemArray?[indexPath.row] {
            do{
                try realm.write(){
                    // Update data in reaml
                    thisItem.done = !thisItem.done
                    
                    //For del below code
                    //realm.delete(thisItem)
                }
            }
            catch {
                print("Error in Updationn\(error)")
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
       
    }
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textfeild = UITextField()
        let alert = UIAlertController(title: "Add New Todoy Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if let currentCategory = self.selectedCategory{
                do {
                    try self.realm.write{
                        var newItem = Item()
                        newItem.title = textfeild.text!
                        currentCategory.items.append(newItem)
                    }
                    
                }
                    catch{
                        print("Error \(error)")
                    }
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
    //MARK: - LoadFunction
    
    func loaditem(){
        itemArray = selectedCategory?.items.sorted(byKeyPath: "title",ascending: true)
        tableView.reloadData()
        }
}
extension TodoListViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loaditem()
            
            DispatchQueue.main.async {
                
               searchBar.resignFirstResponder()
            }
        }
    }
}

