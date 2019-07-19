//
//  MeetingListTableViewCell.swift
//  MeetingNotes
//
//  Created by jithin varghese on 25/05/18.
//  Copyright © 2018 Jithin Varghese. All rights reserved.
//

import UIKit

class MeetingListTableViewCell: UITableViewCell {
    //meeting image outlet
    @IBOutlet weak var imgMeetingImage: UIImageView!
    
    //description label outlet
    @IBOutlet weak var lblDescription: UILabel!
    
    //totlae lable outlet
    @IBOutlet weak var lblTitle: UILabel!
    
    //date lable outlet
    @IBOutlet weak var lblDate: UILabel!
    
    //Task Class object is created
    var dataList : Task?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //Dispaly the data to the cell
    func showData(){
        
        if let img = dataList?.taskImage{
            self.imgMeetingImage.image = img
        }
        
        if let title = dataList?.title{
            self.lblTitle.text = title
        }
        if let meetingDescription = dataList?.taskDescription{
            self.lblDescription.text = meetingDescription
        }
        if let date = dataList?.date{
            self.lblDate.text = "Date: " + date
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
