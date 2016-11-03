//
//  NoteViewController.swift
//  Record
//
//  Created by Wang Weihan on 3/3/16.
//  Copyright © 2016 Wang Weihan. All rights reserved.
//

import UIKit
import CoreData

class NoteViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var bodyTextView: UITextView!
    
    var note :NSManagedObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Note"
        if let note = note {
            titleTextField.text = note.value(forKey: "title") as? String
            bodyTextView.text = note.value(forKey: "body") as! String
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(NoteViewController.saveNote))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func saveNote() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        if note == nil {
            let noteEntity =  NSEntityDescription.entity(forEntityName: "Note", in: managedContext)
            note = NSManagedObject(entity: noteEntity!, insertInto:managedContext)
        }
        
        note?.setValue(titleTextField.text, forKey: "title")
        note?.setValue(bodyTextView.text, forKey: "body")
        
        // Complete save and handle potential error
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
        
        self.navigationController?.popToRootViewController(animated: true)
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
