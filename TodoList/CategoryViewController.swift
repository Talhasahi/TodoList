//
//  TableViewController.swift
//  TodoList
//
//  Created by Talha on 11/03/2020.
//  Copyright © 2020 Talha. All rights reserved.
//

import UIKit
import CoreData
class CategoryViewController: UITableViewController {
    
     let datFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
     //var itemArray = [Item]()
    var itemArray = [Item]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          itemArray.count
      }
      override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "toDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[0].title
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
          
          //itemArray[indexPath.row].done =  !itemArray[indexPath.row].done
          //update using saveitem
          //del using saveitem
         // context.delete(itemArray[indexPath.row])
          //itemArray.remove(at: indexPath.row)
          saveItem()
     
          tableView.reloadData()
         
      }
    @IBAction func addCategory(_ sender: UIBarButtonItem) {
       
    }
   func    saveItem(){
        
    }
    
}
