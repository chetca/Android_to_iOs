//
//  GiveMeMoneyTextField.swift
//  memuDemo
//
//  Created by Dugar Badagarov on 09/09/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

class GiveMeMoneyTextField: UITextField, UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let allwoedCh = CharacterSet.decimalDigits
        let chSet = CharacterSet(charactersIn: string)
        
        return allwoedCh.isSuperset(of: chSet)
    }

}
