//
//  TableViewController.swift
//  TodoList
//
//  Created by Talha on 11/03/2020.
//  Copyright © 2020 Talha. All rights reserved.
import UIKit
import CoreData
import RealmSwift
//realm store the data in form of Object
class CategoryTableViewController: UITableViewController {
    let realm = try!  Realm()
    var categories : Results<Categories>?
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    @IBAction func AddCategory(_ sender: UIBarButtonItem) {
               var textfeild = UITextField()
               let alert = UIAlertController(title: "Add New Todoy Category", message: "", preferredStyle: .alert)
               let action = UIAlertAction(title: "Add", style: .default) { (action) in
                let newCategory = Categories()
                newCategory.name = textfeild.text!
                self.saveData(category: newCategory)
                    self.tableView.reloadData()
        }
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create A new Item"
            textfeild = alertTextField
            }
            present(alert,animated: true,completion: nil)
        tableView.reloadData()
    }
    //MARK: - countArray
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return   categories?.count ?? 1
    }
    //MARK: - cellForRowAt
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCategoryCell", for: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No category Added Yet"
        return cell
    }
    //MARK: - didSelectRowAt
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "goToItem", sender: self)
        }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
            
        }
    }
        
    func saveData(category : Categories){
        do{
            try realm.write(){
                realm.add(category)
            }
        }catch {
          print("Error in Write Dtaa\(error)")
        }
        tableView.reloadData()
    }
    func loadData(){
        //pull all the Item in the categories table
        categories = realm.objects(Categories.self)
        tableView.reloadData()
               
    }
    
}
