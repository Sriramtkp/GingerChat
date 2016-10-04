//
//  ChatViewController.swift
//  GingerChat
//
//  Created by Sriram Rajendran on 15-9-16.
//  Copyright © 2016 Sriram Rajendran. All rights reserved.
//

import UIKit
import JSQMessagesViewController


class ChatViewController: JSQMessagesViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

      self.senderId = "Me"
      self.senderDisplayName = "Shri"
      
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  override func collectionView(collectionView: JSQMessagesCollectionView!, didTapMessageBubbleAtIndexPath indexPath: NSIndexPath!) {
    
    
  }
  
  override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
    print("Send Btn Pressed\(text)")
    
    
    self.finishSendingMessage()
      }
  
  
  override func didPressAccessoryButton(sender: UIButton!) {
    
    print("attachment Btn Pressed")
    
  }
  
  
}
