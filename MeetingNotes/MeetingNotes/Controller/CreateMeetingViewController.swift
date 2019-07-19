//
//  CreateMeetingViewController.swift
//  MeetingNotes
//
//  Created by jithin varghese on 24/05/18.
//  Copyright © 2018 Jithin Varghese. All rights reserved.
//

import UIKit

class CreateMeetingViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate {
    
    //Create metting outlets is created
    @IBOutlet weak var imgAddPhoto: UIImageView!
    
    @IBOutlet weak var txtTitle: UITextField!
    
    @IBOutlet weak var txtDecription: UITextView!
    
    @IBOutlet weak var btnSave: UIButton!
    
    @IBOutlet weak var btnAddPhoto: UIButton!
    
    var objTaskArray = [Task]()
    
    var objImage : UIImage?
    
    let imagePicker = UIImagePickerController()
    
    //To check the image is selected or not
    var isImageSelected : Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        btnSave.layer.cornerRadius = 4
        
        txtDecription.layer.borderWidth = 1
        txtDecription.layer.borderColor = UIColor.greyPlaceholderColor().cgColor
        txtDecription.layer.cornerRadius = 4
        txtDecription.delegate = self
        txtDecription.text = "Enter Description"
        txtDecription.textColor = UIColor.greyPlaceholderColor()
        
        self.imagePicker.delegate = self
        isImageSelected = false
        btnAddPhoto.setTitle("Add Photo", for: .normal)
        
        self.title = "Create Meeting"
        
        /** To dismiss the Keyborad when user press view
         **/
        self.hideKeyboardWhenTappedAround() 
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /** User can select the image from Camera or Gallery**/
    @IBAction func btnAddPhotoPressed(_ sender: Any) {
        let alert = UIAlertController(title:"Add image", message:nil, preferredStyle: .actionSheet) // 1
        let cameraAction = UIAlertAction(title: "Open Camera", style: .default) { (alert: UIAlertAction!) -> Void in
            
            //open Camera
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
                
                self.imagePicker.sourceType = .camera;
                self.imagePicker.allowsEditing = false
                self.present(self.imagePicker, animated: true, completion: nil)
                
            }
        } // 2
        
        let galleryAction = UIAlertAction(title: "Choose From Gallery", style: .default) { (alert: UIAlertAction!) -> Void in
            
            //open libaray
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
                
                self.imagePicker.sourceType = .photoLibrary;
                self.imagePicker.allowsEditing = true
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        } // 3
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { (alert: UIAlertAction!) -> Void in
            self.dismiss(animated: true, completion: nil)
        }//3
        
        alert.addAction(cameraAction)//1
        alert.addAction(galleryAction)//2
        alert.addAction(cancelAction)//3
        
        
        
        DispatchQueue.main.async {
            // This will helps to display the action sheet in the ipad,In ipad action sheet is displayed with the help of sourceview and sourcerect ,//
            if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad ){
                
                if let popoverController = alert.popoverPresentationController {
                    popoverController.sourceView = self.btnAddPhoto
                    popoverController.sourceRect = self.btnAddPhoto.bounds
                }
                self.present(alert, animated: true, completion: nil)
                
            }else{
                self.present(alert, animated: true, completion:nil)
            }
            
        }
    }
    
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.imgAddPhoto.image = image
        objImage = image
        isImageSelected = true
        btnAddPhoto.setTitle("Change Photo", for: .normal)
        dismiss(animated:true, completion: nil)
    }
    
    /** This Data are saved into the UserDefault**/
    @IBAction func btnSavePressed(_ sender: Any) {
        if isImageSelected{
            if validate(){
                
                
                let title = self.txtTitle.text
                let taskDescription = self.txtDecription.text
                
                let currentDate = getCurrentDate()
                
                let objTask = Task(taskImage: objImage!, title: title!, taskDescription: taskDescription!, date: currentDate)
                objTaskArray = getPreviosDataToArray()
                objTaskArray.append(objTask)
                let data = NSKeyedArchiver.archivedData(withRootObject: objTaskArray)
                UserDefaults.standard.set(data, forKey: "task")
                
                
                if (UserDefaults.standard.object(forKey: "task")) != nil{
                    self.txtTitle.text = ""
                    self.txtDecription.text = ""
                    self.imgAddPhoto.image = nil
                    isImageSelected = false
                    btnAddPhoto.setTitle("Add Photo", for: .normal)
                    
                }
            }
        }
        else{
            showAlert(message: "Please Add Image")
        }
    }
    
    /**Helps to append pervios data to the array or else we will lose the data because each time we are initilizing the array**/
    func getPreviosDataToArray() -> [Task]
    {
        
        var taskArray = [Task]()
        if let data = UserDefaults.standard.object(forKey: "task")  as? Data
        {
            taskArray = NSKeyedUnarchiver.unarchiveObject(with: data) as! [Task]
        }
        
        return taskArray
    }
    /** This method return the current date as String**/
    func getCurrentDate() -> String{
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let currentDate = formatter.string(from: date)
        return currentDate
    }
    
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        if (txtDecription.text == "Enter Description")
        {
            txtDecription.text = ""
            txtDecription.textColor = .black
        }
        txtDecription.becomeFirstResponder() //Optional
    }
    
    func textViewDidEndEditing(_ textView: UITextView)
    {
        if (txtDecription.text == "")
        {
            txtDecription.text = "Enter Description"
            txtDecription.textColor = UIColor.greyPlaceholderColor()
        }
        txtDecription.resignFirstResponder()
    }
    
    /**To Validate the feilds is blank,If feild is empty  it will return flase else true
     **/
    func validate() -> Bool{
        var status = true
        
        guard let title = self.txtTitle.text,!title.isBlank else {
            self.showWarningAlert(message: "Please Enter Title")
            status = false
            return status
        }
        if !(self.txtDecription.text == "Enter Description"){
            guard let desc = self.txtDecription.text,!desc.isBlank else {
                self.showWarningAlert(message: "Please Enter Description")
                status = false
                return status
            }
        }
            
        else{
            self.showWarningAlert(message: "Please Enter Description")
            status = false
            return status
        }
        return status
    }
    
    
    
    
    
}
