//
//  ViewController.swift
//  Tasks
//
//  Created by s0x on 2020-04-16.
//  Copyright © 2020 s0x. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    //array that hold all tasks
    var tasks = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="Tasks"
        tableView.delegate = self
        tableView.dataSource =  self
       //for initial setup block to insure it start up the count from zero
        if !UserDefaults().bool(forKey: "setup"){
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count")
        }
        
        //all saved tasks
        updateTasks()

    }
    // we call this function everytime we first start app to fitch and update array task from what ever we saved
    func updateTasks(){
        //to remove all elements in array tasks to avoid duplicate
       tasks.removeAll()
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        
        for x in 0..<count {
            if let task = UserDefaults().value(forKey: "task_\(x+1)") as? String {
                //return
                tasks.append(task)
            }
        }
        
        tableView.reloadData()
    }
    
    //this function is called when we press add button to add new task
    @IBAction func didTapAdd(){
        let vc = storyboard?.instantiateViewController(identifier: "entry") as! EntryViewController
        
        vc.title = "New Task!!!!"
               
        vc.update = {
            DispatchQueue.main.async {
              self.updateTasks()

            }
        }
        //navigationController?.pushViewController(vc, animated: true)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //delete function
    func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        return true
    }

    /*func tableView(tableView: UITableView!, commitEditingStyle editingStyle:   UITableViewCell.EditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            tableView.beginUpdates()
           // tasks.removeAtIndex(indexPath!.row)
            //tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: nil)
            tableView.endUpdates()

        }*/
   // }
    
    
    
 }
// this for table view,which is what happen when we select a cell
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
//supplies the number of rows which is "number of tasks"
extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row]
        return cell
    }
  }
 
