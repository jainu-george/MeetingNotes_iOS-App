//
//  ExtensionMethods.swift
//  MeetingNotes
//
//  Created by jithin varghese on 29/05/18.
//  Copyright © 2018 Jithin Varghese. All rights reserved.
//

import UIKit

//Extension files for  alert and dismissing the keyboard
extension UIViewController{
    
    /** show the alert message  **/
    func showAlert(message: String?) {
        let alerController = UIAlertController(title: "Meeting Note", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alerController.addAction(cancelAction)
        present(alerController, animated: true, completion: nil)
    }
    
    func showAlertwithTitle(title: String, message: String) {
        let alerController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alerController.addAction(cancelAction)
        present(alerController, animated: true, completion: nil)
    }
    
    /** Show warning alert **/
    func showWarningAlert(message: String){
        self.showAlertwithTitle(title: "Warning!", message: message)
    }
    
    /** hide the keyboard using tap gestutre **/
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


//Color extension fil
extension UIColor {
   
    //helps to get placholder colaor for textview
    class func greyPlaceholderColor() -> UIColor {
        return UIColor(red: 0.78, green: 0.78, blue: 0.80, alpha: 1.0)
    }
}

//String extension if string is empty return bool value
extension String {
    var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
            return trimmed.isEmpty
        }
    }
}
