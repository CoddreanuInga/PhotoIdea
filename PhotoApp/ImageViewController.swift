//
//  ImageViewController.swift
//  PhotoApp
//
//  Created by Tcacenco Daniel on 11/24/15.
//  Copyright © 2015 Inga. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController,UIScrollViewDelegate {
    
    
    
    var image : UIImage!
    @IBOutlet var ImageGestorView: UIImageView!
    @IBOutlet var scrollView: UIScrollView!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        ImageGestorView.image = image
        ImageGestorView.userInteractionEnabled = true
        //now you need a tap gesture recognizer
        //note that target and action point to what happens when the action is recognized.
        let tapRecognizer = UIPinchGestureRecognizer(target: self, action: Selector("pinchDetected:"))
        //Add the recognizer to your view.
        ImageGestorView.addGestureRecognizer(tapRecognizer)
        let pinchRecognizer = UIPanGestureRecognizer(target: self, action: Selector("pinDetected:"))
        ImageGestorView.addGestureRecognizer(pinchRecognizer)
        let tappRecognizer = UITapGestureRecognizer(target: self, action: Selector("tapDetected:"))
        tappRecognizer.numberOfTapsRequired = 2
        ImageGestorView.addGestureRecognizer(tappRecognizer)
            }
    
    func pinDetected(pinRecognizer : UIPanGestureRecognizer)
    {
        self.view.bringSubviewToFront(pinRecognizer.view!)
        var translation = pinRecognizer.translationInView(self.view)
        let magnitude = sqrt((translation.x * translation.x) + (translation.y * translation.y))
        let slideMultiplier = magnitude / 200
         let slideFactor = 0.1 * slideMultiplier
        var finalPoint = CGPoint(x:pinRecognizer.view!.center.x + (translation.x * slideFactor),
            y:pinRecognizer.view!.center.y + (translation.y * slideFactor))
        // 4
        finalPoint.x = min(max(finalPoint.x, 0), self.view.bounds.size.width)
        finalPoint.y = min(max(finalPoint.y, 0), self.view.bounds.size.height)
        
    }
    
    
    func pinchDetected(pinchRecognizer : UIPinchGestureRecognizer)
    {
        self.view.bringSubviewToFront(self.ImageGestorView)
        pinchRecognizer.view!.transform = CGAffineTransformScale(pinchRecognizer.view!.transform, pinchRecognizer.scale, pinchRecognizer.scale)
        pinchRecognizer.scale = 1.0
        
    }
    
    func tapDetected (tapRecognizer : UITapGestureRecognizer)
    {
        UIView.animateWithDuration(0.25) { () -> Void in
            self.ImageGestorView.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds))
            self.ImageGestorView.transform = CGAffineTransformIdentity
        }
    }
    
    

}
