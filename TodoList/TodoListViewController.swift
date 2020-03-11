//
//  ViewController.swift
//  TodoList
//
//  Created by Talha on 09/03/2020.
//  Copyright © 2020 Talha. All rights reserved.
//

import UIKit
import CoreData
class TodoListViewController: UITableViewController {
  
 //Create Own Plist For Store data
     let datFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    // item is from croe data class
    @IBOutlet weak var searchBar: UISearchBar!
    var itemArray = [Item]()
       let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
       loaditem()
    } 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        if itemArray[indexPath.row].done == true {
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
        
        itemArray[indexPath.row].done =  !itemArray[indexPath.row].done
        //update using saveitem
        //del using saveitem
       // context.delete(itemArray[indexPath.row])
        //itemArray.remove(at: indexPath.row)
        saveItem()
   
        tableView.reloadData()
       
    }
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textfeild = UITextField()
        let alert = UIAlertController(title: "Add New Todoy Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
         
            var item = Item(context:  self.context  )
            item.title = textfeild.text!
            item.done = false
            self.itemArray.append(item)
            self.saveItem()
            self.tableView.reloadData()
            
        }
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create A new Item"
            textfeild = alertTextField
        }
        present(alert,animated: true,completion: nil)
    }
    func loaditem(with request : NSFetchRequest<Item> = Item.fetchRequest()){
        do{
          itemArray =   try context.fetch(request)
        }
        catch{
            
        }
        tableView.reloadData()
        }
    func saveItem(){
        do{
             try context.save()
        }catch {
            
        }
        tableView.reloadData()
    }
    
        
    
}
extension TodoListViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item>  = Item.fetchRequest()
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true )]
        //create comtum request
        loaditem(with : request)
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loaditem()
            //
            DispatchQueue.main.async {
                
               searchBar.resignFirstResponder()
            }
            
        }
    }
}
