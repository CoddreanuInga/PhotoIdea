//
//  ViewController.swift
//  PhotoApp
//
//  Created by Inga Codreanu on 11/13/15.
//  Copyright © 2015 Inga. All rights reserved.
//

import UIKit
import CoreData
import MapKit
import AssetsLibrary




class ViewController: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate, MKMapViewDelegate
{
    
    @IBOutlet var textField: UITextField!

    
    @IBOutlet var map: MKMapView!
    var latitudine :NSNumber!
    var longitudine: NSNumber!
    var latitudeToShare: NSNumber!
    var longitudeToShare: NSNumber!
    var ImagePreview: UIImageView!
    var ExistingItem:NSManagedObject!
    var imagGetterDetail : NSData!
    var notee : String = ""
    @IBOutlet var latShow: UILabel!
    @IBOutlet var longShow: UILabel!
    @IBOutlet var locationBuuton: UIButton!
    var titleLocation : String!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if( ExistingItem != nil){
            textField.text = notee
            ImagePreview.image = UIImage(data: imagGetterDetail)
            latShow.text! = ("\(latitudine)")
            longShow.text! = ("\(longitudine)")
            }
        
        ImagePreview.userInteractionEnabled = true
        //now you need a tap gesture recognizer
        //note that target and action point to what happens when the action is recognized.
        let tapRecognizer = UITapGestureRecognizer(target: self, action: Selector("imageTapped:"))
        //Add the recognizer to your view.
        ImagePreview.addGestureRecognizer(tapRecognizer)
        
         }
    
    
    
    override func viewDidAppear(animated: Bool)
    {
       let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
       let context: NSManagedObjectContext = appDel.managedObjectContext
        
    }
    
    
    func imageTapped(gestureRecognizer: UITapGestureRecognizer)
    {
        //tappedImageView will be the image view that was tapped.
        //dismiss it, animate it off screen, whatever.
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc: ImageViewController = storyBoard.instantiateViewControllerWithIdentifier("imageXib") as! ImageViewController
        //tranmitem imaginea care deja e salvata in core data
        vc.image = ImagePreview.image
        [self.navigationController?.pushViewController(vc, animated: true)]
    }
    
    
    @IBAction func PhotoLIbrary(sender: AnyObject)
    {
       
      if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary){
            print("Button capture")
            let imag = UIImagePickerController()
            imag.delegate = self
            imag.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
            //imag.mediaTypes = [kUTTypeImage];
            imag.allowsEditing = false
            self.presentViewController(imag, animated: true, completion: nil)
        }

    }
    
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!) {
        let selectedImage : UIImage = image
        ImagePreview.image=selectedImage
        self.dismissViewControllerAnimated(true, completion: nil)
        
        }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
            if picker.sourceType == UIImagePickerControllerSourceType.PhotoLibrary {
            
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            ImagePreview.image = image
            
            let library = ALAssetsLibrary()
            var url: NSURL = info[UIImagePickerControllerReferenceURL] as! NSURL
            
            library.assetForURL(url, resultBlock: {
                (asset: ALAsset!) in
                if asset.valueForProperty(ALAssetPropertyLocation) != nil {
                    
                    self.latitudine = (asset.valueForProperty(ALAssetPropertyLocation) as! CLLocation!).coordinate.latitude
                    self.longitudine = (asset.valueForProperty(ALAssetPropertyLocation) as! CLLocation!).coordinate.longitude
                 
//                    self.titleLocation = fileName as String
                    
                    
                    print(self.latitudine)
                    print(self.longitudine)
                    
                }
                }, failureBlock: {
                    (error: NSError!) in
                    NSLog("Error!")
            })
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    @IBAction func saveButton(sender: AnyObject)
      {
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext
        let en = NSEntityDescription.entityForName("Data", inManagedObjectContext: context)
        
    
        
            if (ExistingItem != nil){
        ExistingItem.setPrimitiveValue(textField.text! as String, forKey: "note")
        ExistingItem.setPrimitiveValue(ImagePreview.image! as UIImage, forKey: "image")
        ExistingItem.setPrimitiveValue(latitudine, forKey: "lat")
        ExistingItem.setPrimitiveValue(longitudine, forKey: "long")
                
                
        }else
        {
            let newNote = Data(entity: en!,insertIntoManagedObjectContext: context)
            newNote.note = textField.text!
            let imgData = UIImageJPEGRepresentation(ImagePreview.image!, 1)
            newNote.image  = imgData
            newNote.lat = latitudine
            newNote.long = longitudine

        }
        do {
            try context.save()
        } catch _ {
        }
        self.navigationController?.popToRootViewControllerAnimated(true)
    
    }
    
override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
{  if latitudine == nil{
    var alert = UIAlertController(title: "Alert", message: "No Location, can't preview image location", preferredStyle:    UIAlertControllerStyle.Alert)
    alert.addAction(UIAlertAction(title: "Dissmis", style: UIAlertActionStyle.Default, handler: nil))
    self.presentViewController(alert, animated: true, completion: nil)
    }else{
    if segue.identifier == "map"
        
    {
       let IVC: MapViewController = segue.destinationViewController as! MapViewController
        
        IVC.latitud = latitudine
        IVC.longitudine = longitudine
       }
      }
    }
    

}

