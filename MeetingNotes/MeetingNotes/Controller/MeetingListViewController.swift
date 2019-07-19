//
//  MeetingListViewController.swift
//  MeetingNotes
//
//  Created by jithin varghese on 25/05/18.
//  Copyright © 2018 Jithin Varghese. All rights reserved.
//

import UIKit
import Foundation

class MeetingListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tblMeetingList: UITableView!
    
    var objMeetingList : [Task]?
    var tempList :[Task]?
    var strSearchKey : String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        objMeetingList = tempList
        
        
        // Do any additional setup after loading the view.
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        if let objTask = UserDefaults.standard.object(forKey: "task") as? Data{
            objMeetingList = NSKeyedUnarchiver.unarchiveObject(with: objTask) as? [Task]
        }
        tempList = objMeetingList
        self.title = "Meeting List"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objMeetingList!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "meetingCell") as! MeetingListTableViewCell
        cell.dataList = objMeetingList?[indexPath.row]
        cell.showData()
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let MeetingDetailtVC = self.storyboard?.instantiateViewController(withIdentifier: "showMeetingDetailSceneID") as! ViewMeetingDetailViewController
        MeetingDetailtVC.objMeetingDetails = objMeetingList?[indexPath.row]
        self.navigationController?.pushViewController(MeetingDetailtVC, animated: true)
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

extension MeetingListViewController : UISearchBarDelegate{
    
    func updateSearchResults(for searchController: UISearchController){
        
    }
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        print(searchBar.text!)
        strSearchKey = searchBar.text!
        self.searchBar.resignFirstResponder()
        
    }
    
   

    // This method updates objMeetingList based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, objMeetingList is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        
        objMeetingList = searchText.isEmpty ? tempList : tempList?.filter { (item:Task) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return item.title?.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil ||  item.date?.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
                ||  item.taskDescription?.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        
        //print("search result ======",objMeetingList!)
        
        tblMeetingList.reloadData()
    }
    
    
    
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false;
    }
    
    
    
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
        
        self.searchBar.resignFirstResponder()
        strSearchKey = nil
        //tblMeetingList.reloadData()
        
    }
    
    
}

