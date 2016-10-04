//
//  OTPViewController.swift
//  GingerChat
//
//  Created by Sriram Rajendran on 06/09/16.
//  Copyright © 2016 Sriram Rajendran. All rights reserved.
//

import UIKit

class OTPViewController: UIViewController, UITextFieldDelegate {

  //MARK: Outlets
  
  
  @IBOutlet weak var textFieldOTP: UITextField!
  
  
  
  @IBOutlet weak var brnVerify: UIButton!
  
  
  @IBOutlet weak var btnResentOTP: UIButton!
  
  
  
 
  
  //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
            
      
      
      //textFiled
      self.textFieldOTP.backgroundColor = UIColor.clearColor()
        self.textFieldOTP.attributedPlaceholder = NSAttributedString(string:"OTP",
      attributes:[NSForegroundColorAttributeName: UIColor.blackColor()])
      
      
      //subViewForLabel
      
      //OTP Button
      self.btnResentOTP.layer.cornerRadius = self.btnResentOTP.frame.size.height/2
      
            //Verify Button
      self.brnVerify.layer.cornerRadius = self.brnVerify.frame.size.height/2
           self.title = "OTP"
      self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
      
      self.navigationItem.hidesBackButton = true
      
      //tap gesture
//      let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.DismissKeyboard))
      
      let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(OTPViewController.DismissKeyboard))
      view.addGestureRecognizer(tap)
      
      
    }

  
  
  //MARK: TextFields Delegates
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    
    self.view.endEditing(true)
    
    return true
  }
  
  
  func DismissKeyboard() {
    
    self.view.endEditing(true)
    
  }
  
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

 
  override func viewWillAppear(animated: Bool) {
    btnResentOTP.hidden = true
    NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(OTPViewController.appear(_:)), userInfo: self, repeats: false)
    
  }
  
  //MARK: Animate Button
  func appear(timer: NSTimer) {
    self.btnResentOTP.hidden = true
    NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(OTPViewController.disappear(_:)), userInfo: self, repeats: false)
    
  }
  
  func disappear(timer: NSTimer) {
    self.btnResentOTP.hidden = false
    NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: #selector(OTPViewController.appear(_:)), userInfo: self, repeats: false)
    
  }
  
  //MARK: Action for Button
  @IBAction func btnResentOTPclicked(sender: UIButton) {
    //timer for animation
    self.btnResentOTP.hidden = true
    NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(OTPViewController.appear(_:)), userInfo: self, repeats: false)
    
    
    
    
    
  }
  
  
  
  
  @IBAction func btnVerifyDidClick(sender: UIButton) {
    
    let url : String =  "http://chat.gingerboxmobility.com/Api/UserAction/ChatLogin"
    
    //Parameters
    let otpText: String = textFieldOTP.text!
    
    let params: [String: AnyObject] = ["message" : otpText]
    
    
    Server.sendPost(url, params: params, completionHandler: { (data, response, error) in
      
      print(Server.dataToNSDictionary(data))
      
      let messageData = Server.dataToNSDictionary(data)
      print("data values are ----> \(messageData?.allKeys)")
      //                print(messageData!.objectAtIndex(1))
      
    })
    
    if otpText.characters.count == 6 {
      
      
      
    }
    

  }
  

}

