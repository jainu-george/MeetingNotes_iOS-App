//
//  ViewMeetingDetailViewController.swift
//  MeetingNotes
//
//  Created by jithin varghese on 29/05/18.
//  Copyright © 2018 Jithin Varghese. All rights reserved.
//

import UIKit

class ViewMeetingDetailViewController: UIViewController {
    
    @IBOutlet weak var txtTitle: UITextField!
    
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var imgMeetingPhoto: UIImageView!
    
    var objMeetingDetails : Task?
    
    @IBOutlet weak var lblDate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.title = "Meeting Details"
        
        
        if let pic = objMeetingDetails?.taskImage{
            imgMeetingPhoto.image = pic
        }
        if let title = objMeetingDetails?.title{
            txtTitle.text = title
        }
        if let date = objMeetingDetails?.date{
            lblDate.text = "Created on :" + date
        }
        
        if let decri = objMeetingDetails?.taskDescription{
            txtDescription.text = decri
        }
        
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
