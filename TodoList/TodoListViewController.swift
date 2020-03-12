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
     let datFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    @IBOutlet weak var searchBar: UISearchBar!
    var itemArray = [Item]()
       let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
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
            item.parentCategory = self.selectedCategory
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
    //MARK: - LoadFunction
    func loaditem(with request : NSFetchRequest<Item> = Item.fetchRequest(),predicat  : NSPredicate? = nil){
    let categorypredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        //add two NSCompoundPredicate means two condition
        if let addtionalPredicate = predicat {
            let compoundPreicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categorypredicate,addtionalPredicate])
             request.predicate = compoundPreicate
        }
        else{
            request.predicate = categorypredicate
        }
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
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true )]
        //create comtum request
        loaditem(with : request,predicat : predicate )
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            //loaditem()
            //
            DispatchQueue.main.async {
                
               searchBar.resignFirstResponder()
            }
        }
    }
}
