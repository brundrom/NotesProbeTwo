//
//  ViewController.swift
//  NotesApplication
//
//  Created by pga on 25.04.2022.
//  Copyright © 2022 pga. All rights reserved.
//

import UIKit
import CoreData

class NoteDetailVC: UIViewController {
    
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var descTV: UITextView!
    
    var selectedNote: Note? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(selectedNote != nil)
        {
            titleTF.text = selectedNote?.title
            descTV.text = selectedNote?.desc
        }
    }
    
    @IBAction func saveAction(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        if(selectedNote == nil)
            {
                let entity = NSEntityDescription.entity(forEntityName: "Note", in: context)
                let newNote = Note(entity: entity!, insertInto: context)
                newNote.id = noteList.count as NSNumber
                newNote.title = titleTF.text
                newNote.desc = descTV.text
                do
            {
                try context.save()
                noteList.append(newNote)
                navigationController?.popViewController(animated: true)
            }
            catch
            {
                print("Saving context failure")
            }
        }
        else {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
            do {
                let results: NSArray = try context.fetch(request) as NSArray
                for result in results
                {
                    let note = result as! Note
                    if(note == selectedNote)
                    {
                        note.title = titleTF.text
                        note.desc = descTV.text
                        try context.save()
                        navigationController?.popViewController(animated: true)
                    }
                }
            }
            catch
            {
                print("Bad fetch")
            }
        }
    }
    @IBAction func DeleteNote(_ sender: Any)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
            let results: NSArray = try context.fetch(request) as NSArray
            for result in results
            {
                let note = result as! Note
                if(note == selectedNote)
                {
                    note.deletedDate = Date()
                    
                    try context.save()
                    navigationController?.popViewController(animated: true)
                }
            }
        }
        catch
        {
            print("Bad fetch")
        }
    }
    
}

