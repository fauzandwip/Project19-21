//
//  DetailViewController.swift
//  Project19-21
//
//  Created by Fauzan Dwi Prasetyo on 12/05/23.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var noteTitleField: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    
    var noteTitle = ""
    var noteText = ""
    
    var defaults = UserDefaults.standard
    var notes: [Note]?
    var note: Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let note {
            noteTitleField.text = note.noteTitle
            noteTextView.text = note.noteText
        }
        
        noteTitleField.delegate = self
        noteTextView.delegate = self
        
        noteTitleField.text = noteTitle
        noteTextView.text = noteText
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        guard notes != nil else { return }
        guard let note else { return }
        
        notes?.insert(note, at: 0)
        saveData()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    
    func saveData() {
        let jsonEncoder = JSONEncoder()
        
        do {
            let savedData = try jsonEncoder.encode(notes)
            defaults.set(savedData, forKey: "notes")
        } catch {
            print("Failed to save data, \(error)")
        }
        
    }
    
}


// MARK: - UITextFieldDelegate & UITextViewDelegate Method
extension DetailViewController: UITextFieldDelegate, UITextViewDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard note != nil else { return }
        
        note?.noteTitle = noteTitleField.text ?? ""
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        guard note != nil else { return }
        
        note?.noteText = noteTextView.text ?? ""
    }
}
