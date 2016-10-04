//
//  SerachFriendsViewController.swift
//  GingerChat
//
//  Created by Sriram Rajendran on 22-9-16.
//  Copyright © 2016 Sriram Rajendran. All rights reserved.
//

import UIKit

class SerachFriendsViewController: UIViewController {

  var filteredArray = [AnyObject]()
  var arrayTable = [AnyObject]()
  
  let resultSearchController = UISearchController(searchResultsController: nil)
  
  
    override func viewDidLoad() {
        super.viewDidLoad()

      resultSearchController.dimsBackgroundDuringPresentation = false
      resultSearchController.searchBar.placeholder = "Type to search"
      resultSearchController.searchBar.searchBarStyle = UISearchBarStyle.Prominent
//      tableViewOutlet.tableHeaderView = resultSearchController.searchBar
      
      
      
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    
    if resultSearchController.active {
      return filteredArray.count
    }
    
    
    
    
    return arrayTable.count
    
    
  }
  
  
  
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
    
    
    let cell = tableView.dequeueReusableCellWithIdentifier("connection")
    
    
    if resultSearchController.active {
      
      cell?.textLabel?.text = filteredArray[indexPath.row] as? String
      
    }else {
      
      cell?.textLabel?.text = arrayTable[indexPath.row] as? String
    }
    return cell!
    
  }

  
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
