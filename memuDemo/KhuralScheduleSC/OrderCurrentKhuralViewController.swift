//
//  OrderCurrentKhuralViewController.swift
//  memuDemo
//
//  Created by Dugar Badagarov on 08/09/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

class OrderCurrentKhuralViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var fullNameTextField: UITextField!
    @IBOutlet var sumTextField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!    
    @IBOutlet var commentForStar: UILabel!
    
    var dateFormater = DateFormatter()
    var stringDatePicker : String = ""
    var khuralTitle : String = ""
    var khuralDate :  String = "" 
    @IBAction func orderKhuralButton(_ sender: Any) {
        //checkInputData
        //print("oooh, you tuch my tralala")
        
        if (fullNameTextField.text == "") {
            JSONTaker.shared.showAlert(title: "Обязательные поля заполнены не верно", message: "", viewController: self)
        }
        else if (fullNameTextField.text?.lowercased().contains("amadeus"))! {
            UIApplication.shared.openURL(URL(string: "https://www.youtube.com/watch?v=cVikZ8Oe_XA")!)
        }
        else {                
            dateFormater.dateFormat = "dd-MM-yyyy"
            stringDatePicker = dateFormater.string(from: datePicker.date)
            
            JSONTaker.shared.onPostTapped(API: "/order/create", parameters:[
                "name": fullNameTextField.text!,
                "date": stringDatePicker,
                "summ": sumTextField.text!,
                "title": khuralTitle,
                "khuralDate": khuralDate]) 
        }
        
        //yandex money
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        sumTextField.keyboardType = UIKeyboardType.numberPad
        khuralTitle = StringLblText
        khuralDate = StringDataField
        commentForStar.sizeToFit()
        
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        
        datePicker.maximumDate = Calendar.current.date(from: components)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        
        datePicker.maximumDate = Calendar.current.date(from: components)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
