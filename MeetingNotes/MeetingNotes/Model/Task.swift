//
//  Task.swift
//  MeetingNotes
//
//  Created by jithin varghese on 24/05/18.
//  Copyright © 2018 Jithin Varghese. All rights reserved.
//

import UIKit

class Task: NSObject,NSCoding {
    
    //store the meeting note image
    var taskImage: UIImage?
    
    //title of the meeting note
    var title:String?
    
    //Description of the meeting
    var taskDescription: String?
    
    //date that created the meeting
    var date: String?
    
     init(taskImage : UIImage,title:String,taskDescription :String,date:String) {
        self.taskImage = taskImage
        self.title = title
        self.taskDescription = taskDescription
        self.date = date
    }
    
    func encode(with aCoder: NSCoder) {
        if let value = taskImage{
        aCoder.encode(value, forKey: "taskImage")
        }
         if let value = title{
        aCoder.encode(value, forKey: "title")
        }
         if let value = taskDescription{
        aCoder.encode(value, forKey: "taskDescription")
        }
         if let value = date{
        aCoder.encode(value, forKey: "date")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        self.taskImage = aDecoder.decodeObject(forKey: "taskImage") as? UIImage
        self.title = aDecoder.decodeObject(forKey: "title") as? String
        self.taskDescription = aDecoder.decodeObject(forKey: "taskDescription") as? String
        self.date = aDecoder.decodeObject(forKey: "date") as? String
        
        
    }

}
