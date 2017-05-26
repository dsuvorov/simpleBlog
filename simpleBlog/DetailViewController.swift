//
//  DetailViewController.swift
//  simpleBlog
//
//  Created by Dmitry Suvorov on 24/05/17.
//  Copyright © 2017 ip-suvorov. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    let network = MyNetwork.sharedInstance // network
    let db = MyDB.sharedInstance // db
    let sync = SyncManager.sharedInstance // syncmanager for async uploading posts

    @IBOutlet weak var imageUrlTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!

    @IBAction func saveBtnPressed(_ sender: Any) {
        if imageUrlTextField.text != "" && userNameTextField.text != "" && textView.text != "" {
            let ps = postSctruct(id: 0, date: self.datePicker.date, name: self.userNameTextField.text!, body: self.textView.text, userPicUrl: self.imageUrlTextField.text)
            self.db.addPostToQueue(post: ps)
            self.sync.startSync()
            _ = navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageUrlTextField.delegate = self
        self.userNameTextField.delegate = self
        self.textView.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tap(gesture:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func tap(gesture: UITapGestureRecognizer) {
        self.textView.resignFirstResponder()
        self.imageUrlTextField.resignFirstResponder()
        self.userNameTextField.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension DetailViewController: UITextFieldDelegate, UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
}

