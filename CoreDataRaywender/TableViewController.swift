//
//  TableViewController.swift
//  CoreDataRaywender
//
//  Created by cuong on 12/12/17.
//  Copyright © 2017 nguyencuong. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    var people: [NSManagedObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let manageContext = appDelegate.persistentContainer.viewContext
        
        let fetchedRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
        
        do {
            people = try manageContext.fetch(fetchedRequest)
        } catch {
            
        }
        
    }
    
    @IBAction func addname(_ sender: UIBarButtonItem) {
        addNames()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addNames() {
        let alertController = UIAlertController(title: "Add new name", message: "input name", preferredStyle: .alert)
        alertController.addTextField { (textFieltf) in
            textFieltf.placeholder = "input name .."
        }
        let saveAction = UIAlertAction(title: "Save", style: .default) { (action) in
            guard let textField = alertController.textFields?.first?.text else { return }
            self.save(name: textField)
            self.tableView.reloadData()
        }
        
        alertController.addAction(saveAction)
        present(alertController, animated: true, completion: nil)
        
    }
    
    func save(name: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let manageContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: manageContext)!
        let person = NSManagedObject(entity: entity, insertInto: manageContext)
        
        person.setValue(name, forKey: "name")
        
        do {
            try manageContext.save()
            people.append(person)
        } catch {
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let person = people[indexPath.row]
        cell.textLabel?.text = person.value(forKey: "name") as? String

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let manageContext = UIApplication.shared.delegate as? AppDelegate
            manageContext?.delete(people[indexPath.row])
            people.remove(at: indexPath.row)
            manageContext?.saveContext()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
