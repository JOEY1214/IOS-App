//
//  addDueDateViewController.swift
//  ScienceAPP
//
//  Created by 张睿 on 29/5/18.
//  Copyright © 2018 张睿. All rights reserved.
//

import UIKit

protocol addDue {
    func AddDue(title:String,type:String,date:String)
}

class addDueDateViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
   
    var delegate : addDue?
    @IBAction func addAction(_ sender: Any) {
        
        if titlelabel.text != "" && typelabel.text != ""  && datelabel.text != ""{
            delegate?.AddDue(title: titlelabel.text!, type: typelabel.text!, date: datelabel.text!)
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBOutlet weak var titlelabel: UITextField!
    @IBOutlet weak var typelabel: UITextField!
    @IBOutlet weak var datelabel: UITextField!
    @IBOutlet weak var addButton: UIButton!

    let type = ["Teaching","General","Research"]
    let picker = UIDatePicker()
    var pickview = UIPickerView()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        addButton.layer.cornerRadius = addButton.frame.height/2
        addButton.clipsToBounds = true
        typelabel.inputView = pickview
        typelabel.textAlignment = .center
        datelabel.textAlignment = .center
        titlelabel.textAlignment = .center
        typelabel.placeholder = "Select Category"
        titlelabel.placeholder = "Enter Your Work"
        datelabel.placeholder = "Due Date"
        pickview.delegate = self
        pickview.dataSource = self
    }


    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return type.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
         return type[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        typelabel.text = type[row]
        typelabel.resignFirstResponder()
    }
    
    func createDatePicker(){
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //done button for toolbar
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([done], animated: true)
        datelabel.inputAccessoryView = toolbar
        datelabel.inputView = picker
        picker.datePickerMode = .date
    }
    
    @objc func donePressed(){
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let dateString = formatter.string(from: picker.date)
        datelabel.text = "\(dateString)"
        self.view.endEditing(true)
        
    }
}
