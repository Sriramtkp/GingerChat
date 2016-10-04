//
//  ViewController.swift
//  GingerChat
//
//  Created by Sriram Rajendran on 30/08/16.
//  Copyright © 2016 Sriram Rajendran. All rights reserved.
//

import UIKit
import SystemConfiguration
import CoreLocation
import CoreTelephony
import MobileCoreServices
import SystemConfiguration

#if (arch(i386) || arch(x86_64)) && os(iOS)
let DEVICE_IS_SIMULATOR = true
#else
let DEVICE_IS_SIMULATOR = false
#endif


struct Platform {
  static let isSimulator: Bool = {
    var isSim = false
    #if arch(i386) || arch(x86_64)
      isSim = true
    #endif
    return isSim
  }()
}

public extension UIDevice {
  
  var modelName: String {
    var systemInfo = utsname()
    uname(&systemInfo)
    let machineMirror = Mirror(reflecting: systemInfo.machine)
    let identifier = machineMirror.children.reduce("") { identifier, element in
      guard let value = element.value as? Int8 where value != 0 else { return identifier }
      return identifier + String(UnicodeScalar(UInt8(value)))
    }
    
    switch identifier {
    case "iPod5,1":                                 return "iPod Touch 5"
    case "iPod7,1":                                 return "iPod Touch 6"
    case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
    case "iPhone4,1":                               return "iPhone 4s"
    case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
    case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
    case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
    case "iPhone7,2":                               return "iPhone 6"
    case "iPhone7,1":                               return "iPhone 6 Plus"
    case "iPhone8,1":                               return "iPhone 6s"
    case "iPhone8,2":                               return "iPhone 6s Plus"
    case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
    case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
    case "iPhone8,4":                               return "iPhone SE"
    case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
    case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
    case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
    case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
    case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
    case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
    case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
    case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
    case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
    case "iPad6,3", "iPad6,4", "iPad6,7", "iPad6,8":return "iPad Pro"
    case "AppleTV5,3":                              return "Apple TV"
    case "i386", "x86_64":                          return "Simulator"
    default:                                        return identifier
    }
  }
  
}


//WebSocketDelegate


class ViewController: UIViewController,UITextFieldDelegate, CLLocationManagerDelegate  {
  /*
  var socket: WebSocket?
  var connectionTrue :Bool = false
  var isConnected : Bool = false
  var myTimer: NSTimer!
 */
  

  
      @objc enum MobileDataConnectionType: UInt {
      case Unknown
      
      case GPRS
      case Edge
      case ThreeGee
      case LTE
      
      func networkName () -> String {
        switch self {
        case Unknown: return "Unknown"
        case GPRS: return "GPRS"
        case Edge: return "Edge"
        case ThreeGee: return "ThreeGee"
        case LTE : return "LTE"
        }
      }
  
  
  }
    
    
  
  
  
  
  
  //MARK: Outlets
  
  @IBOutlet weak var emailTextField: UITextField!

  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var loginBtnOutlet: UIButton!
  
  @IBOutlet weak var rememberBtnOutlet: UIButton!
  //MARK: Variables

  var VersionName: String = "V 0.0.1"
 var locationInfoDict = [String: AnyObject]()
 var mobileBrand: Bool = false
  var IsGPS : Int = 1
  var PublicIP: String = ""
  var localIPAddressVar = String()
  var MacID: String = ""
  var Lat:String = "Lat"
  var Longt:String = "Longt"
  var CellId: String = "CellId"
  var LAC: String = "LAC"
  var MCC: String = "MCC"
  var MNC: String = "MNC"
  
  var msgVar = String()
  var tokenVar = NSDictionary()
  var statusVar = Bool()
  var typeVar = Int()
  
  
  
 
  var globalVarLocationManager = CLLocationManager ()
  var latitudeVar = CLLocationDegrees()
  var longitudeVar = CLLocationDegrees()
  var userLocationVar = CLLocation()

  var networkInfoGVar = CTTelephonyNetworkInfo()
  var carrierGVar = CTCarrier()
  
  
  
  
  
  
  //MARK: viewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
 
    
    let imageBtnGreen = UIImage(named: "btnBlack")
    
    self.rememberBtnOutlet.setImage(imageBtnGreen, forState: .Normal)
    
    
    //Call the funcs
    dataStatus()
    locationCurrent()
    
    //tap gesture
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.DismissKeyboard))
    view.addGestureRecognizer(tap)
    //cornerRadius
    self.loginBtnOutlet.layer.borderWidth = 1.0
    self.loginBtnOutlet.layer.borderColor = UIColor.greenColor().CGColor
    self.loginBtnOutlet.layer.cornerRadius = self.loginBtnOutlet.frame.size.height/2
    
    self.emailTextField.attributedPlaceholder = NSAttributedString(string:"Email id",
                                                                   attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
    
    self.passwordTextField.attributedPlaceholder = NSAttributedString(string:"Password",
                                                                      attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])

    
    
    
    /*
    socket = WebSocket(url: NSURL(string: "ws://192.168.0.100/MvcWebsocketChat/chat.ashx?username=kk")!)
     socket!.delegate = self
     socket!.connect()
     
     myTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(ViewController.timerFunc), userInfo: nil, repeats: true)
 */
    
    
    }

  
  //MARK: Location register
  
  func locationCurrent() {
    
    globalVarLocationManager.delegate = self
    globalVarLocationManager.desiredAccuracy = kCLLocationAccuracyBest
    globalVarLocationManager.requestWhenInUseAuthorization()
    globalVarLocationManager.startUpdatingLocation()
    
  }
  
  func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    userLocationVar = locations[0]
    longitudeVar = userLocationVar.coordinate.longitude;
    latitudeVar = userLocationVar.coordinate.latitude;
        }
  
  
  //MARK: CurrentReachabilityStatus wifi or data
  
  func dataStatus() {
    let reachability: Reachability
    do {
      reachability = try Reachability.reachabilityForInternetConnection()
    } catch {
      print("Unable to create Reachability")
      return
    }
    NSNotificationCenter.defaultCenter().addObserver(self,
                                                     selector: #selector(ViewController.reachabilityChanged(_:)),
                                                     name: ReachabilityChangedNotification,
                                                     object: reachability)
    do {
      try reachability.startNotifier()
    } catch {
      print("This is not working.")
      return
    }
  }
  
  //MARK: Reachability
  
  func reachabilityChanged(note: NSNotification) {
    
    let reachability = note.object as! Reachability
    
    if reachability.isReachable() {
      if reachability.isReachableViaWiFi() {
        print("Reachable via WiFi")
      } else {
        print("Reachable via Cellular")
      }
    } else {
      //      showNoConnectionAlert()
      print("Not reachable")
    }
  }
  
  //MARK: Action
  
  
  @IBAction func buttonRememberMe(sender: UIButton) {
    
    
    
    
    
    if emailTextField.text == "" || passwordTextField.text == "" {
      
      dispatch_async(dispatch_get_main_queue(), {
        
        self.displayAlert("Missing Field(s)", MessageTxt: "User name and Password requiered")
        let imageBtnGreen = UIImage(named: "btnBlack")
        
        self.rememberBtnOutlet.setImage(imageBtnGreen, forState: .Normal)
        
      })
      }
    else{
    let imageBtnGreen = UIImage(named: "btnGreen")
    self.rememberBtnOutlet.setImage(imageBtnGreen, forState: .Normal)
    
    }
    
    
    
  }
  
  @IBAction func buttonLogin(sender: UIButton) {
            if emailTextField.text == "" || passwordTextField.text == "" {
      
              dispatch_async(dispatch_get_main_queue(), { 
               
                self.displayAlert("Missing Field(s)", MessageTxt: "User name and Password requiered")
                
              })
              
      self.dismissViewControllerAnimated(true, completion: nil)
      
    }
    else{
            
        let url : String =  "http://chat.gingerboxmobility.com/Api/UserAction/ChatLogin"
              
    //              var networkInfoGVar = CTTelephonyNetworkInfo()
//              var carrierGVar = CTCarrier()
     networkInfoGVar = CTTelephonyNetworkInfo()
              
    carrierGVar = networkInfoGVar.subscriberCellularProvider!
              // Get carrier name
              let countryCode = carrierGVar.mobileCountryCode
              print( countryCode)
              let networkCode = carrierGVar.mobileNetworkCode
              print(networkCode)
             let modelNamePrint = UIDevice.currentDevice().modelName
              print(modelNamePrint)
              //Parameters
              let user: String = emailTextField.text!
              let passw: String = passwordTextField.text!
              let params: [String: AnyObject] = ["EmailId": user,"Pass": passw, "VersionName": VersionName, "locationInfo": ["IsMobile": mobileBrand, "IsGPS": IsGPS, "PublicIP": PublicIP, "LocalIP": localIPAddressVar, "MacID": "", "Lat" :  latitudeVar, "Longt": longitudeVar, "CellId":"", "LAC":"", "MCC":"", "MNC":""]]
      
             Server.sendPost(url, params: params, completionHandler: loginCH)
              
//              Server.sendPost(url, params: params, completionHandler: { (data, response, error) in
//                
//                
//                print(Server.dataToNSDictionary(data))
//                
//               let messageData = Server.dataToNSDictionary(data)
////                print("data values are ----> \(messageData?.allKeys)")
////                print(messageData!.objectAtIndex(1))
//                
//              })
              
//      print(params)
              
//              let userNameText = NSUserDefaults.standardUserDefaults().objectForKey("EmailId")
//              let passwordText = NSUserDefaults.standardUserDefaults().objectForKey("Pass")
              
             
              
              
              
    }
    
  }
  
  


  //MARK: callBack Funcs
  
  
  func loginCH(data: NSData?, response: NSURLResponse?, error: NSError?){
    dispatch_async(dispatch_get_main_queue(), {
      let messageData = Server.dataToNSDictionary(data)
      
      NSUserDefaults.standardUserDefaults().setObject(messageData?["EmailId"], forKey: "EmailId")
      NSUserDefaults.standardUserDefaults().setObject(messageData?["Pass"], forKey: "Pass")
      NSUserDefaults.standardUserDefaults().setObject(messageData?["VersionName"], forKey: "VersionName")
      
      NSUserDefaults.standardUserDefaults().setObject(messageData?["locationInfoDict"], forKey: "locationInfo")
            NSUserDefaults.standardUserDefaults().setObject(messageData!["IsGPS"], forKey: "IsGPS")
            NSUserDefaults.standardUserDefaults().setObject(messageData!["Lat"], forKey: "Lat")
            NSUserDefaults.standardUserDefaults().setObject(messageData!["Longt"], forKey: "Longt")
      NSUserDefaults.standardUserDefaults().setObject(messageData!["MCC"], forKey: "MCC")
      NSUserDefaults.standardUserDefaults().setObject(messageData!["MCC"], forKey: "MCC")
      
      NSUserDefaults.standardUserDefaults().setObject(messageData!["tokenVar"], forKey: "tokenVar")
      NSUserDefaults.standardUserDefaults().setObject(messageData!["msgVar"], forKey: "msgVar")
      NSUserDefaults.standardUserDefaults().setObject(messageData!["statusVar"], forKey: "statusVar")
       NSUserDefaults.standardUserDefaults().setObject(messageData!["typeVar"], forKey: "typeVar")
      
      
      print(messageData!.objectForKey("message"))
      self.msgVar = (messageData!.objectForKey("message") as? String)!
      //                print(messageData?.allKeysForObject("token"))
      print(self.msgVar)
      
      self.typeVar = (messageData!.objectForKey("type") as? Int)!
      self.statusVar = (messageData!.objectForKey("status") as? Bool)!
      self.msgVar = (messageData!.objectForKey("message") as? String)!
      self.tokenVar = (messageData?.valueForKey("data") as? NSDictionary)!
      print("tokenVar is -- \(self.tokenVar)")
      
      print(self.typeVar)
      
      if self.typeVar == 101 {
        
//        self.performSegueWithIdentifier("updatePassword", sender: self)
      }else if self.typeVar == 102{
        
//        self.performSegueWithIdentifier("segueOTP", sender: self)
        
        
      }else if self.typeVar == 401{
        
        self.displayAlert("Missing Field(s)", MessageTxt: "User name and Password requiered")
        
        
      }else if self.typeVar == 402{
        
        self.displayAlert("Retry", MessageTxt: "Invalid User Name")
        
        
      }else if self.typeVar == 403{
        
        self.displayAlert("Retry", MessageTxt: "Invalid Password")
        
      }else if self.typeVar == 404{
        
        print("Location details is missing")
        
      }else if self.typeVar == 405{
        
        print("Undefined")
        
      }else if
        self.typeVar == 416{
        
        
        self.performSegueWithIdentifier("", sender: self)
        
      }
      
          
    })
  }

  //MARK: Alert
  
  
  func displayAlert(titleMsg: String, MessageTxt: String) {
    
    //    dispatch_async(dispatch_get_main_queue(), {
    
    let alert = UIAlertController(title: titleMsg , message: MessageTxt , preferredStyle: .Alert)
    
    let saveAction = UIAlertAction(title: "Ok", style: .Default) {
      (action: UIAlertAction) -> Void in
      
      self.dismissViewControllerAnimated(true, completion: nil)
    }
    //       })
    
    alert.addAction(saveAction)
    alert.view.setNeedsLayout()
    
    
    presentViewController(alert, animated: true, completion: nil)
    
    
  }

 
  
  //MARK: TextFields Delegates
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    
    self.view.endEditing(true)
    
    return true
  }
  
  func DismissKeyboard() {
  
    self.view.endEditing(true)
    
  }
  
  // MARK: Websocket Delegate Methods.
/*
  func websocketDidConnect(ws: WebSocket) {
    
    connectionTrue = Server.isConnectedToInternet()
    isConnected = true;
    //    print(connectionTrue)
    if connectionTrue == true {
      
      print("websocket is connected")
    }
  }
  
  
  func websocketDidDisconnect(ws: WebSocket, error: NSError?) {
    isConnected = false;
    connectionTrue = Server.isConnectedToInternet()
    //    print(connectionTrue)
    if connectionTrue == false{
      
      print("websocket is connected")
    }else{
      print("Disconnected")
      
      if let e = error {
        print("websocket is disconnected: \(e.localizedDescription)")
      } else {
        print("websocket disconnected")
      }
    }
  }
  
  
  func websocketDidReceiveMessage(ws: WebSocket, text: String) {
    print("Received text: \(text)")
  }
  
  func websocketDidReceiveData(ws: WebSocket, data: NSData) {
    print("Received data: \(data.length)")
  }
  
//MARK: timerFunc()
  func timerFunc() {
    
    
    connectionTrue = Server.isConnectedToInternet()
    
    
    if connectionTrue && !isConnected {
      print("reConnect with Tap wifi....\(connectionTrue.description)")
      socket!.connect()
      isConnected = true;
    }else if !connectionTrue{
      print("reConnect with Tap wifi.socket not connected...\(connectionTrue.description)")
      isConnected = false;
      
    }
    
    
    }

 */
 
  
   override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}


