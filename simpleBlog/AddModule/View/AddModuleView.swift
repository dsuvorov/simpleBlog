//
// Created by VIPER
// Copyright (c) 2017 VIPER. All rights reserved.
//

import Foundation
import UIKit

class AddModuleView: UIViewController, AddModuleViewProtocol {
    var presenter: AddModulePresenterProtocol?
    @IBOutlet weak var imageUrlTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewHasBeenLoaded()
        
        self.imageUrlTextField.delegate = self
        self.userNameTextField.delegate = self
        self.textView.delegate = self

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tap(gesture:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        presenter?.saveBtnPressed()
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

extension AddModuleView: UITextFieldDelegate, UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
}
