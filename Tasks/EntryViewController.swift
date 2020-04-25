//
//  EntryViewController.swift
//  Tasks
//
//  Created by s0x on 2020-04-17.
//  Copyright © 2020 s0x. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var field : UITextField!
    var update: (() -> Void )?
    
    override func viewDidLoad() {
        super.viewDidLoad()
         field.delegate=self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "save task", style: .done, target: self, action: #selector(saveTask))
     }
    
     //The text field calls this method whenever the user taps the return button.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveTask()
        return true
    }
    
    @objc func saveTask(){
        //to make sure the text field is not empty
        guard let text = field.text, !text.isEmpty  else {
            return
        }
         //increament the count
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        //}
        
        let newCount = count + 1
        //save the new task
        UserDefaults().set(newCount, forKey: "count")
        UserDefaults().set(text, forKey: "task_\(newCount)")
        //call this method if exisit
        update?()
        navigationController?.popViewController(animated: true)
    }
}
