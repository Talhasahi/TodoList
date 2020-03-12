//
//  TableViewController.swift
//  TodoList
//
//  Created by Talha on 11/03/2020.
//  Copyright © 2020 Talha. All rights reserved.

import UIKit
import CoreData
class CategoryTableViewController: UITableViewController {
    var categories = [Categories]()
    // it just use for find location whear
   let datFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    //for data base first You need to create cotext
     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    @IBAction func AddCategory(_ sender: UIBarButtonItem) {
               var textfeild = UITextField()
               let alert = UIAlertController(title: "Add New Todoy Category", message: "", preferredStyle: .alert)
               let action = UIAlertAction(title: "Add", style: .default) { (action) in
                var item = Categories(context: self.context)
                item.name = textfeild.text!
                   self.categories.append(item)
                self.saveData()
                    self.tableView.reloadData()
        }
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create A new Item"
            textfeild = alertTextField
            }
            present(alert,animated: true,completion: nil)
    }
    //MARK: - countArray
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    //MARK: - cellForRowAt
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCategoryCell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name
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
            destinationVC.selectedCategory = categories[indexPath.row]
            print(categories[indexPath.row])
        }
    }
        
    func saveData(){
        do{
             try context.save()
        }catch {
            
        }
        tableView.reloadData()
    }
    func loadData(){
           var  request : NSFetchRequest<Categories> = Categories.fetchRequest()
        do{
                 categories =   try context.fetch(request)
               }
               catch{
                print(error)
               }
               tableView.reloadData()
    }
    
}
