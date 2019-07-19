//
//  LoginViewController.swift
//  login
//
//  Created by Garry on 29/05/18.
//  Copyright © 2018 MIT. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var userUsernameTextField: UITextField!
    @IBOutlet weak var lblMessage: UILabel!
    
    //Customer objects created
    var objCustomer : [Customer]?
    var tempList :[Customer]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //To make login button corner carve
        btnLogin.layer.cornerRadius = 4
        
        lblMessage.isHidden = true
        
        /**To remove the "Back" title from thw navivation bar**/
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        
        //Checking for the nil value in userDefault
        if UserDefaults.standard.object(forKey: "customer") != nil{
            if let objCust = UserDefaults.standard.object(forKey: "customer") as? Data{
                objCustomer = NSKeyedUnarchiver.unarchiveObject(with: objCust) as? [Customer]
            }
            tempList = objCustomer
        }
        
        
        /** To dismiss the Keyborad when user press view
         **/
        self.hideKeyboardWhenTappedAround() 
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /** Login action calls here **/
    @IBAction func loginButton(_ sender: UIButton)
    {
        
        
        if userUsernameTextField.text?.isEmpty ==  true{
            showAlert(message:" Please enter Username")
            
        }else if userPasswordTextField.text?.isEmpty == true{
            showAlert(message:"Please eneter Password" )
            
        }else{
            
            let username = userUsernameTextField.text!
            let password = userPasswordTextField.text!
            
            
            //Cheking the array for the exiscting username and password,if it is true then home screen is displayed else warning alert is displayed.Ternary conditional operator
            objCustomer = (username.isEmpty) ? tempList : tempList?.filter { (item:Customer) -> Bool in
                // If dataItem matches the searchText, return true to include it
                return item.username?.range(of: username, options: .caseInsensitive, range: nil, locale: nil) != nil &&  item.password?.range(of: password, options: .caseInsensitive, range: nil, locale: nil) != nil
                
            }
            if ((objCustomer?.count) != nil)  {
                if (objCustomer?.count) != 0 {
                    
                    let HomeVC = self.storyboard?.instantiateViewController(withIdentifier: "homeSceneID") as! HomeViewController
                    //let navController = UINavigationController(rootViewController: HomeVC)
                    //self.present(navController, animated: true, completion: nil)
                    
                    self.navigationController?.pushViewController(HomeVC, animated: true)
                }
                else{
                    lblMessage.isHidden = false
                    lblMessage.text = "Wrong Credential"
                    showAlert(message: "Wrong Credential")
                }
            }
            else{
                lblMessage.isHidden = false
                lblMessage.text = "Wrong Credential"
                showAlert(message: "Wrong Credential")
            }
        }
    }
    
    //Navigat eto the registration controller
    @IBAction func btnRegisterPressed(_ sender: Any) {
        
        let registerVC  = self.storyboard?.instantiateViewController(withIdentifier: "registerSceneID") as! RegisterViewController
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    
    //MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
        
    }
    
    
    //MARK: viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    
}
