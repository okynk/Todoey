//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Oky Nugroho Kusumo on 16/01/2018.
//  Copyright © 2018 Oky Nugroho Kusumo. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    
    var categories : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategory()
        tableView.rowHeight = 80.0
        tableView.separatorStyle = .none
    }

    //MARK : Add new Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add category", style: .default) { (action) in
            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.colour = UIColor.randomFlat.hexValue()
            self.saveCategory(newCategory)
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK : TableView Datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No data"
        guard let color =  UIColor(hexString: categories?[indexPath.row].colour ?? "1D9BF6") else {fatalError()}
        cell.backgroundColor = color
        cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
        return cell
    }
    
    //MARK : TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    //MARK : Data manipulation methods
    func saveCategory(_ category : Category){
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error save \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadCategory(){
        categories = realm.objects(Category.self)
        
        tableView.reloadData()
    }
    
    //MARK : delete data from swipe
    override func updateModel(at indexPath: IndexPath) {
        if let category = self.categories?[indexPath.row]{
            do{
                try self.realm.write {
                    self.realm.delete(category)
                }
            } catch {
                print("error delte \(error)")
            }

        }
    }
}
