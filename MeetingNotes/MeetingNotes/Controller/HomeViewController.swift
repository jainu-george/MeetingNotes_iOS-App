//
//  HomeViewController.swift
//  MeetingNotes
//
//  Created by jithin varghese on 25/05/18.
//  Copyright © 2018 Jithin Varghese. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var btnShowList: UIButton!
    @IBOutlet weak var btnCreate: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        /**To remove the "Back" title fromt ha navihation bar**/
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        
        self.btnCreate.layer.cornerRadius = self.btnCreate.frame.size.width / 2
        self.btnCreate.clipsToBounds = true
        self.btnCreate.layer.borderWidth = 4
        self.btnCreate.layer.borderColor = UIColor.white.cgColor
        
        self.btnShowList.layer.cornerRadius = self.btnShowList.frame.size.width / 2
        self.btnShowList.clipsToBounds = true
        self.btnShowList.layer.borderWidth = 4
        self.btnShowList.layer.borderColor = UIColor.white.cgColor
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /** Create new meeting note**/
    @IBAction func btnCreatMeetingPressed(_ sender: Any) {
        let createMeetingVC = self.storyboard?.instantiateViewController(withIdentifier: "createmeetingSBID") as! CreateMeetingViewController
        self.navigationController?.pushViewController(createMeetingVC, animated: true)
        
    }
    
    /** show the list of meeting note that created**/
    @IBAction func btnShowListPressed(_ sender: Any) {
        
        //        if let objTask = UserDefaults.standard.object(forKey: "task") as? Data{
        //            let objMeetingList = NSKeyedUnarchiver.unarchiveObject(with: objTask) as? Task
        //
        //            if objMeetingList?.date?.count == 0
        //            {
        //                self.showWarningAlert(message:"No Meeting List !,Please Create New Meeting List")
        //
        //
        //            }else{
        //                let MeetingListVC = self.storyboard?.instantiateViewController(withIdentifier: "showMeetingListSceneID") as! MeetingListViewController
        //                self.navigationController?.pushViewController(MeetingListVC, animated: true)
        //            }
        //        }
        
        //Checking the List contains meeting note or nil
        if UserDefaults.standard.object(forKey: "task") == nil{
            
            self.showWarningAlert(message:"No Meeting List !,Please Create New Meeting List")
            
            
        }else{
            let MeetingListVC = self.storyboard?.instantiateViewController(withIdentifier: "showMeetingListSceneID") as! MeetingListViewController
            self.navigationController?.pushViewController(MeetingListVC, animated: true)
        }
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


