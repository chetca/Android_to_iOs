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
    
    var khuralTitle : String = ""
    var khuralDate :  String = "" 
    @IBAction func orderKhuralButton(_ sender: Any) {
        //checkInputData
        print("oooh, you tuch my tralala")
        
        if (fullNameTextField.text == "") {
            JSONTaker.shared.showAlert(title: "Обязательные поля заполнены не верно", message: "", viewController: self)
        }
        else {
        
        
            JSONTaker.shared.onPostTapped(API: "/order/create", parameters: [fullNameTextField.text!,
                                                            datePicker.date as! String,
                                                            sumTextField.text!,
                                                            khuralTitle,
                                                            khuralDate]) 
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
     

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
