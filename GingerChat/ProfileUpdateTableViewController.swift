//
//  ProfileUpdateTableViewController.swift
//  GingerChat
//
//  Created by Sriram Rajendran on 07/09/16.
//  Copyright © 2016 Sriram Rajendran. All rights reserved.
//

import UIKit

class ProfileUpdateTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {

  
  
  //MARK: Outlets
  @IBOutlet weak var addBtnProperty: UIButton!
  @IBOutlet weak var imageViewProfile: UIImageView!
  
  @IBOutlet weak var textFirstName: UITextField!
  @IBOutlet weak var textMiddleName: UITextField!
  @IBOutlet weak var textLastName: UITextField!
  

  
  //MARK: Action
  @IBAction func addPhotoButton(sender: AnyObject) {
    let pickCntrl = UIImagePickerController()
    pickCntrl.delegate = self
    pickCntrl.allowsEditing = true
    
    let alert = UIAlertController(title: "Add a picture", message: "Choose from", preferredStyle: .Alert)
    
    let cameraAction = UIAlertAction(title: "Carmea", style: .Default, handler: {
      (action: UIAlertAction) -> Void in
      pickCntrl.sourceType = .Camera
      
    self.presentViewController(pickCntrl, animated: true, completion: nil)
    })
    
    
    let photoAlbumAction = UIAlertAction(title: "Photo Library", style: .Default, handler: {
      (action: UIAlertAction) -> Void in
      pickCntrl.sourceType = .PhotoLibrary
      
      self.presentViewController(pickCntrl, animated: true, completion: nil)
    })
    
    let savedPhotosAlbumAction = UIAlertAction(title: "Saved Photos Album", style: .Default, handler: {
      (action: UIAlertAction) -> Void in
      pickCntrl.sourceType = .SavedPhotosAlbum
      
      self.presentViewController(pickCntrl, animated: true, completion: nil)
    })
    
    
    let cancelAlert = UIAlertAction(title: "Cancel", style: .Destructive) {
      (action: UIAlertAction) -> Void in
      
    }
    
    alert.addAction(cameraAction)
    alert.addAction(photoAlbumAction)
    alert.addAction(savedPhotosAlbumAction)
    
    alert.addAction(cancelAlert)

        alert.view.setNeedsLayout()
    alert.view.layoutIfNeeded()

    presentViewController(alert, animated: true, completion: nil)
    
  }
  
  
  func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
    
    self.dismissViewControllerAnimated(true, completion: nil)
    
    self.imageViewProfile.image = image
    
  }
  
  
  
  
  
  //MARK: viewDidLoad
  
    override func viewDidLoad() {
        super.viewDidLoad()

      
//      self.navigationController?.navigationBar.layer.cornerRadius = (self.navigationController?.navigationBar.bounds.height)!/2
      
  self.title = "Update Profile"
      self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.blueColor()]
      
      self.navigationItem.hidesBackButton = true
      
//     self.doneBarBtnProperty.tintColor = UIColor.whiteColor()
//      self.navigationController?.navigationBar.barTintColor = UIColor.blueColor()
      

      imageViewProfile.layer.cornerRadius = imageViewProfile.bounds.height / 2
      imageViewProfile.clipsToBounds = true
      
      
      
      
      
       //tap gesture inside ViewDidLoad
      let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.DismissKeyboard))
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

  @IBAction func updateBtnPressed(sender: UIBarButtonItem) {
    
    self.view.endEditing(true)

    
    self.performSegueWithIdentifier("historySegue", sender: self)
    
    
  }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
/*
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
      return 1

    }

  
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//      
//      let cell = tableView.dequeueReusableCellWithIdentifier("cellDate") as UITableViewCell!
//      
//      
//      
//      return cell
//    }
  
*/
  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
    
    let imageSelected  = info[UIImagePickerControllerOriginalImage] as? UIImage
    self.imageViewProfile.image = imageSelected

    if self.imageViewProfile.image == imageSelected {
      self.addBtnProperty.titleLabel?.textColor = UIColor.redColor()

      self.addBtnProperty.titleLabel?.text = "\n\\n\n\n\n\n\\n\n\n\n\n\\n\n\n\n\n\\n\n\n\n\n\\n\n\n\n\n\\n\n\n\n\n\\n\n\n\n\n\\n\n\n\n\n\\n\n\n\n\n\\n\n\n\n\n\\n\n\n\n\n\\n\n\n\n\n\\n\n\n\n\n\\n\n\n\n\n\\n\n\n\n\n\\n\n\n\n\n\\n\n\n\n\n\\n\n\n\n\n\\n\n\n\n\n\\n\n\n\n\n\\n\n\n\n\n\\n\n\n\n\n\\n\n\n\n\n\\n\n\n\n\n\\n\n\n\n\n\\n\n\n\n\n\\n\n\n\n\n\\n\n\n\n\n\\n\n\n\n\n\\n\n\n\n\n\\n\n\n\n\n\\n\n\n\n\n\\n\n\n\n\n\\n\n\n\n\n\\n\n\n\n\n\\n\n\n\n\n\\n\n\n\n\n\\n\n\n\n\n\\n\n\n\n\n\\n\n\n\n\n\\n\n\n\n\n\\n\n\n\n\n\\n\n\n\n\n\\n\nedit photo"
      
      
    }else{
      self.addBtnProperty.titleLabel?.textColor = UIColor.blueColor()

      self.addBtnProperty.titleLabel?.text = "add Photo"

      

    }
    
        self.dismissViewControllerAnimated(true, completion: nil)
    
  }
  
  //MARK: viewWillAppear
  override func viewWillAppear(animated: Bool) {
    self.tableView.backgroundView = UIImageView(image: UIImage(named: "bg1"))
    
    
  }
  
  override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView //recast your view as a UITableViewHeaderFooterView
//    header.contentView.backgroundColor = UIColor(red: 0/255, green: 181/255, blue: 229/255, alpha: 1.0) //make the background color light blue
    header.textLabel!.textColor = UIColor.whiteColor() //make the text white
    header.alpha = 1 //make the header transparent
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    
    
    
   
    
  }
  
  
  
}
