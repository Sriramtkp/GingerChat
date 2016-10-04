//
//  AppDelegate.swift
//  GingerChat
//
//  Created by Sriram Rajendran on 30/08/16.
//  Copyright © 2016 Sriram Rajendran. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  
//  var mask: CALayer?
//  var imageView: UIImageView?


  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // Override point for customization after application launch.
    
    
    application.statusBarStyle = .LightContent
    
    
    
    
//    UINavigationBar.appearance().backgroundColor = UIColor.init(colorLiteralRed: 23, green: 82, blue: 138, alpha: 0.5 )
    
    //Launch Screen
    
    /*let imageView = UIImageView(frame: self.window!.frame)
    //imageView.image = UIImage(named: "gchat-logo2")
    //self.window!.addSubview(imageView)
    
    //self.mask = CALayer()
    self.mask!.contents = UIImage(named: "gchat logo1")!.CGImage
    self.mask!.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
    self.mask!.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    self.mask!.position = CGPoint(x: imageView.frame.size.width/2, y: imageView.frame.size.height/2)
    imageView.layer.mask = mask
    
    
    let keyFrameAnimation = CAKeyframeAnimation(keyPath: "bounds")
    keyFrameAnimation.duration = 1
    keyFrameAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)]
    let initalBounds = NSValue(CGRect: mask!.bounds)
    let secondBounds = NSValue(CGRect: CGRect(x: 0, y: 0, width: 90, height: 90))
    let finalBounds = NSValue(CGRect: CGRect(x: 0, y: 0, width: 1500, height: 1500))
    keyFrameAnimation.values = [initalBounds, secondBounds, finalBounds]
    keyFrameAnimation.keyTimes = [0, 0.3, 1]
    self.mask!.addAnimation(keyFrameAnimation, forKey: "bounds") 
     ----------------------------
    self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
    
    let imageView = UIImageView(frame: self.window!.frame)
    imageView.image = UIImage(named: "gchat-logo1")
    self.window!.addSubview(imageView)
    self.mask = CALayer()
    self.mask!.contents = UIImage(named: "gchat-logo1")!.CGImage
    self.mask!.contentsGravity = kCAGravityResizeAspect
    self.mask!.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
    self.mask!.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    self.mask!.position = CGPoint(x: imageView.frame.size.width/2, y: imageView.frame.size.height/2)
    
    // Starting from Xcode7, iOS9 requires all UIWindow must have a rootViewController
    let emptyView = UIViewController()
    self.window?.rootViewController = emptyView
    
    imageView.layer.mask = mask
    self.imageView = imageView
    
    animateMask()
    
    // Override point for customization after application launch.
    self.window!.backgroundColor = UIColor(red: 70/255, green: 154/255, blue: 233/255, alpha: 1)
    self.window!.makeKeyAndVisible()
    UIApplication.sharedApplication().statusBarHidden = true

    */
    
    return true
  }

  func applicationWillResignActive(application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    self.saveContext()
  }

  // MARK: - Core Data stack

  lazy var applicationDocumentsDirectory: NSURL = {
      // The directory the application uses to store the Core Data store file. This code uses a directory named "Shri.GingerChat" in the application's documents Application Support directory.
      let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
      return urls[urls.count-1]
  }()

  lazy var managedObjectModel: NSManagedObjectModel = {
      // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
      let modelURL = NSBundle.mainBundle().URLForResource("GingerChat", withExtension: "momd")!
      return NSManagedObjectModel(contentsOfURL: modelURL)!
  }()

  lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
      // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
      // Create the coordinator and store
      let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
      let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
      var failureReason = "There was an error creating or loading the application's saved data."
      do {
          try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
      } catch {
          // Report any error we got.
          var dict = [String: AnyObject]()
          dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
          dict[NSLocalizedFailureReasonErrorKey] = failureReason

          dict[NSUnderlyingErrorKey] = error as NSError
          let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
          // Replace this with code to handle the error appropriately.
          // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
          NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
          abort()
      }
      
      return coordinator
  }()

  lazy var managedObjectContext: NSManagedObjectContext = {
      // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
      let coordinator = self.persistentStoreCoordinator
      var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
      managedObjectContext.persistentStoreCoordinator = coordinator
      return managedObjectContext
  }()

  // MARK: - Core Data Saving support

  func saveContext () {
      if managedObjectContext.hasChanges {
          do {
              try managedObjectContext.save()
          } catch {
              // Replace this implementation with code to handle the error appropriately.
              // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
              let nserror = error as NSError
              NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
              abort()
          }
      }
  }
  
  
  
//  func animateMask() {
//    let keyFrameAnimation = CAKeyframeAnimation(keyPath: "bounds")
//    keyFrameAnimation.delegate = self
//    keyFrameAnimation.duration = 1
//    keyFrameAnimation.beginTime = CACurrentMediaTime() + 1 //add delay of 1 second
//    let initalBounds = NSValue(CGRect: mask!.bounds)
//    let secondBounds = NSValue(CGRect: CGRect(x: 0, y: 0, width: 90, height: 90))
//    let finalBounds = NSValue(CGRect: CGRect(x: 0, y: 0, width: 1500, height: 1500))
//    keyFrameAnimation.values = [initalBounds, secondBounds, finalBounds]
//    keyFrameAnimation.keyTimes = [0, 0.3, 1]
//    keyFrameAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)]
//    self.mask!.addAnimation(keyFrameAnimation, forKey: "bounds")
//  }
//  
//  override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
//    self.imageView!.layer.mask = nil //remove mask when animation completes
//  }

  
  
//  func showLaunchScreen() {
//    let launchScreen = UIStoryboard(name: "LaunchScreen", bundle: nil)
//    let launchView = launchScreen.instantiateInitialViewController()
////    self.view.addSubview(launchView!.view)
//    
//    let timeDelay = dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC)))
//    dispatch_after(timeDelay, dispatch_get_main_queue()) {
//      UIView.animateWithDuration(0.5, animations: { _ in
//        launchView?.view.alpha = 0.0
//      }) { _ in
//        launchView!.view.removeFromSuperview()
//      }
  
  

}

