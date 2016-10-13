//
//  HistoryViewController.swift
//  GingerChat
//
//  Created by Sriram Rajendran on 23-9-16.
//  Copyright © 2016 Sriram Rajendran. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

  
  var arrayTable = [AnyObject]()
  
  var filteredArray = [AnyObject]()
  
  let resultSearchController = UISearchController(searchResultsController: nil)
  
  
  
  
  @IBOutlet weak var tableViewOutlet: UITableView!
  
  
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      
      
      arrayTable = ["Android1","iOS" ,"History Tab" ,"Broadcast as Alert"]

      self.navigationItem.hidesBackButton = true
      
      self.title? = "History"
      self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.redColor()]
      
      definesPresentationContext = true
      resultSearchController.dimsBackgroundDuringPresentation = false
      resultSearchController.searchBar.placeholder = "Type to search"
      resultSearchController.searchBar.searchBarStyle = UISearchBarStyle.Prominent
      tableViewOutlet.tableHeaderView = resultSearchController.searchBar
      
      
      
      
//      
//      self.searchFriendBtnOutlet.tintColor = UIColor.whiteColor()
      
//  UINavigationBar.appearance().backgroundColor = UIColor.whiteColor()
      
//      self.navigationController?.navigationBar.barTintColor = UIColor.greenColor()
      
  }
  
  
//  override func viewWillAppear(animated: Bool) {
//    super.viewWillAppear(animated)
//    let nav = self.navigationController?.navigationBar
//    nav?.barStyle = UIBarStyle.Black
//    nav?.tintColor = UIColor.greenColor()
//    nav?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.orangeColor()]
//  }

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
    
    
    let cell = tableView.dequeueReusableCellWithIdentifier("history")
    
    if resultSearchController.active {
      cell?.textLabel?.text = filteredArray[indexPath.row] as? String

    } else {
    
    
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
