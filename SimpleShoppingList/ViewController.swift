//
//  ViewController.swift
//  SimpleShoppingList
//
//  Created by Gideon Shawana on 2022-10-30.
// 301195054
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    // adding UI to to swiftcontroller
    @IBOutlet weak var shoppingTableView: UITableView!
    
    @IBOutlet weak var newItemTextField: UITextField!
    
    var items: [item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        shoppingTableView.delegate = self
        shoppingTableView.dataSource = self
        
        let item1 = item(name: "Soy milk")
        let item2 = item(name: "Computer")
        
        items = [item1, item2]
        
        loadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath)
        
        let currentItem = items[indexPath.row]
        cell.textLabel?.text = currentItem.name
        return cell
    }

    // add button to upload to list
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        if let newItemName = newItemTextField.text {
            
            let newItem = item(name: newItemName)
            newItemTextField.text = ""
            items.append(newItem)
            shoppingTableView.reloadData()
            
            saveData()
            
        }
        
        
    }
    
    func loadData(){
        
        if let objects = UserDefaults.standard.value(forKey: "items") as? Data {
            
            if let objectsDecoded = try? JSONDecoder().decode(Array.self, from:objects) as [item] {
                
                items = objectsDecoded
            }
        }
    }
    
    func saveData() {
        
        if let encoded = try? JSONEncoder().encode(items){
            
            UserDefaults.standard.set(encoded, forKey: "items")
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            
            items.remove(at: indexPath.row)
            shoppingTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

