//
//  RegisterViewController.swift
//  login
//
//  Created by Garry on 27/05/18.
//  Copyright © 2018 MIT. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    //Registration outlets
    @IBOutlet weak var userConfirmpasswordTextField: UITextField!
    
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    @IBOutlet weak var userUsernameTextField: UITextField!
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var btnRegister: UIButton!
    
    var objCustomerArray = [Customer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        btnRegister.layer.cornerRadius = 4
        
        /** To dismiss the Keyborad when user press view
         **/
        self.hideKeyboardWhenTappedAround() 
    }
    
    /** Resgitstion action is called,if user complet all the feils then the values is saved into the UserDefault **/
    @IBAction func registerButton(_ sender: UIButton)
    {
        
        
        //check for emptyfields
        if userNameTextField.text?.isEmpty == true{
            
            showAlert(message: "Please enter the name")
            
        }else if userUsernameTextField.text?.isEmpty == true{
            
            showAlert(message: "Please enter the Username")
            
        }else if userPasswordTextField.text?.isEmpty == true{
            
            showAlert(message: "Please eneter the passowrd")
            
            
        }else if userConfirmpasswordTextField.text?.isEmpty == true{
            
            showAlert(message: "Please enter the confirm password")
            
        }
            //Check for password matching
        else if (userPasswordTextField.text != userConfirmpasswordTextField.text )
        {
            
            showAlert(message:  "Your password not match")
            
        }
        else{
            
            let userName = userNameTextField.text!
            let userUsername = userUsernameTextField.text!
            let userPassword = userPasswordTextField.text!
            let userConfirmpassword = userConfirmpasswordTextField.text!
            
            let customer = Customer(name: userName, username: userUsername, password:userPassword, confirmPassword: userConfirmpassword)
            
            objCustomerArray = getPreviosDataToArray()
            objCustomerArray.append(customer)
            let data = NSKeyedArchiver.archivedData(withRootObject: objCustomerArray)
            UserDefaults.standard.set(data, forKey: "customer")
            
            

            let HomeVC = self.storyboard?.instantiateViewController(withIdentifier: "homeSceneID") as! HomeViewController
            let navController = UINavigationController(rootViewController: HomeVC)
            self.present(navController, animated: true, completion: nil)
            //self.navigationController?.pushViewController(HomeVC, animated: true)
            
        }
        
    }
    
    /**Helps to append pervios data to the array or else we will lose the data because each time we are initilizing the array**/
    func getPreviosDataToArray() -> [Customer]
    {
        
        var customerArray = [Customer]()
        if let data = UserDefaults.standard.object(forKey: "customer")  as? Data
        {
            customerArray = NSKeyedUnarchiver.unarchiveObject(with: data) as! [Customer]
        }
        
        return customerArray
    }
    
    
    @IBAction func letmebtn(_ sender: UIButton) {
        
       // self.dismiss(animated: true, completion: nil)
    }
    
}
