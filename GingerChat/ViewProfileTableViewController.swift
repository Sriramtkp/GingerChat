//
//  ViewProfileTableViewController.swift
//  GingerChat
//
//  Created by Sriram Rajendran on 28-9-16.
//  Copyright © 2016 Sriram Rajendran. All rights reserved.
//

import UIKit

class ViewProfileTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

      
  self.title = "View Profile"
      self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.blueColor()]
  
  
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  
  

}
