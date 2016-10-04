//
//  ConnectionsViewController.swift
//  GingerChat
//
//  Created by Sriram Rajendran on 23-9-16.
//  Copyright © 2016 Sriram Rajendran. All rights reserved.
//

import UIKit

class ConnectionsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

  
  
  var arrayTable = [AnyObject]()
  
  var filteredArray = [AnyObject]()
  
   let resultSearchController = UISearchController(searchResultsController: nil)
  
  
  @IBOutlet weak var tableViewOutlet: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      arrayTable = ["Android1","iOS" ,"History Tab" ,"We are inside Connections"]

      
      
      
      definesPresentationContext = true
      resultSearchController.dimsBackgroundDuringPresentation = false
      resultSearchController.searchBar.placeholder = "Type to search"
      resultSearchController.searchBar.searchBarStyle = UISearchBarStyle.Prominent
      tableViewOutlet.tableHeaderView = resultSearchController.searchBar
      

      
      
      
//      UINavigationBar.appearance().backgroundColor = UIColor.whiteColor()

//      self.title = "Contacts"
//      self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

  
  
 
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
  
  

  
  
  
  
  
}
