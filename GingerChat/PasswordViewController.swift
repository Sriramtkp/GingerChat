//
//  PasswordViewController.swift
//  GingerChat
//
//  Created by Sriram Rajendran on 06/09/16.
//  Copyright © 2016 Sriram Rajendran. All rights reserved.
//

import UIKit

class PasswordViewController: UIViewController,UITextFieldDelegate {

  
  @IBOutlet weak var textFieldNewPassword: UITextField!
  
  
  @IBOutlet weak var textFieldReEnterNewPassword: UITextField!
  
  @IBOutlet weak var updateButtonOutlet: UIButton!
  
  
  
  
    override func viewDidLoad() {
        super.viewDidLoad()

      self.title = "Password Update"
      self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.blueColor()]
  
      self.navigationItem.hidesBackButton = true
//      self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()

      // btn
      
      
//      tap gesture
     tapView()
      
      self.updateButtonOutlet.layer.cornerRadius = self.updateButtonOutlet.frame.size.height/2

      
      self.view.endEditing(true)
  
  }

  
  func tapView() {
    
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PasswordViewController.DismissKeyboard))
    view.addGestureRecognizer(tap)
    
  }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  //MARK: TextFields Delegates
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    
    self.view.endEditing(true)
    
    return true
  }
  
  
  func DismissKeyboard() {
    
    self.view.endEditing(true)
    
  }

  //MARK: Alert
  func displayAlert(titleMsg: String, MessageTxt: String) {
    
    dispatch_async(dispatch_get_main_queue(), {
    
    let alert = UIAlertController(title: titleMsg , message: MessageTxt , preferredStyle: .Alert)
    
    let saveAction = UIAlertAction(title: "Ok", style: .Default) {
      (action: UIAlertAction) -> Void in
      
      self.dismissViewControllerAnimated(true, completion: nil)
          }
    alert.addAction(saveAction)
    alert.view.setNeedsLayout()
   self.presentViewController(alert, animated: true, completion: nil)
      
      
        })
    
  }
  
  
  
  //MARK : Alert
  @IBAction func updatePasswordButtonPressed(sender: UIButton) {
    
    
    if textFieldNewPassword.text == "" || textFieldReEnterNewPassword.text == "" {
      
      dispatch_async(dispatch_get_main_queue(), {
        
        self.displayAlert("Password Length", MessageTxt: "Password Length should be above 5 and below 30 characters")
        
      })}else{
    
    
    self.performSegueWithIdentifier("updateProfile", sender: self)
    
    }
      
      
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
