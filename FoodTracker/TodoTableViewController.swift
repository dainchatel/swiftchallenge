//
//  TodoTableViewController.swift
//  FoodTracker
//
//  Created by Dain Chatel on 4/20/17.
//
//

import UIKit
import os.log

class TodoTableViewController: UITableViewController {
    //MARK: Properties
    
    var todos = [Todo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        
        // Load any saved meals, otherwise load sample data.
        if let savedTodos = loadTodos() {
            todos += savedTodos
        }
        else {
            // Load the sample data.
            loadSampleTodos()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "TodoTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TodoTableViewCell  else {
            fatalError("The dequeued cell is not an instance of TodoTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let todo = todos[indexPath.row]
        
        cell.nameLabel.text = todo.name

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            todos.remove(at: indexPath.row)
            saveTodos()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
 

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
        case "AddItem":
            os_log("Adding a new todo.", log: OSLog.default, type: .debug)
        case "ShowDetail":
            guard let todoDetailViewController = segue.destination as? TodoViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedTodoCell = sender as? TodoTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedTodoCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedTodo = todos[indexPath.row]
            todoDetailViewController.todo = selectedTodo
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
    
    
    //MARK: Actions
    @IBAction func unwindToTodoList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? TodoViewController, let todo = sourceViewController.todo {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing todo.
                todos[selectedIndexPath.row] = todo
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                // Add a new todo.
                let newIndexPath = IndexPath(row: todos.count, section: 0)
                
                todos.append(todo)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            // Save the todos.
            saveTodos()
        }
    }
    
    //MARK: Private Methods
    
    private func loadSampleTodos() {
        guard let todo1 = Todo(name: "clean garage") else {
            fatalError("Unable to instantiate todo1")
        }
        
        guard let todo2 = Todo(name: "build treehouse") else {
            fatalError("Unable to instantiate todo2")
        }
        
        guard let todo3 = Todo(name: "rake leaves") else {
            fatalError("Unable to instantiate todo3")
        }
        
        todos += [todo1, todo2, todo3]
    }

    private func saveTodos() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(todos, toFile: Todo.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Todos successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save todos...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadTodos() -> [Todo]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Todo.ArchiveURL.path) as? [Todo]
    }
}
