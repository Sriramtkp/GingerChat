//
//  AboutHelpViewController.swift
//  GingerChat
//
//  Created by Sriram Rajendran on 28-9-16.
//  Copyright © 2016 Sriram Rajendran. All rights reserved.
//

import UIKit

class AboutHelpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      
      
      
      self.title = "About and Help"
      
      self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.blueColor()]
      
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func cancelBtn(sender: UIBarButtonItem) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    
    /*
   /
   
   
   
   let imageView = UIImageView(frame: self.window!.frame)
   imageView.image = UIImage(named: "gchat-logo2")
   self.window!.addSubview(imageView)
   
   self.mask = CALayer()
   self.mask!.contents = UIImage(named: "twitter logo mask").CGImage
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
   
   
   }
    */

}
