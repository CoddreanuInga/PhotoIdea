//
//  HomeTableViewController.swift
//  PhotoApp
//
//  Created by Inga Codreanu on 11/13/15.
//  Copyright © 2015 Inga. All rights reserved.
//

import UIKit
import CoreData

class HomeTableViewController: UITableViewController {
   
       var Datas = [Data]()
    
   
    
    override func viewDidAppear(animated: Bool)
    {  let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext
        let request = NSFetchRequest(entityName: "Data")
        Datas = try! context.executeFetchRequest(request) as! [Data]
        self.tableView.reloadData()
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
         if segue.identifier == "update" {
         let selectedIdem: NSManagedObject = (Datas[self.tableView.indexPathForSelectedRow!.row] as NSManagedObject) as NSManagedObject
        
            if selectedIdem.valueForKey("lat") == nil{
            let IVC: ViewController = segue.destinationViewController as! ViewController
            IVC.notee = selectedIdem.valueForKey("note") as! String
            IVC.imagGetterDetail = selectedIdem.valueForKey("image") as! NSData
            IVC.ExistingItem = selectedIdem
            
            
        }else{
            
            let IVC: ViewController = segue.destinationViewController as! ViewController
            
            IVC.notee = selectedIdem.valueForKey("note") as! String
            IVC.imagGetterDetail = selectedIdem.valueForKey("image") as! NSData
            IVC.latitudine = selectedIdem.valueForKey("lat") as! NSNumber
            IVC.longitudine = selectedIdem.valueForKey("long") as! NSNumber
            IVC.ExistingItem = selectedIdem
            }
        }
    }


    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
      return 1
    }

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return Datas.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ObjectsTableViewCell
        let data = Datas[indexPath.row]
        
        
        //let data:NSManagedObject = Datas[indexPath.row] as! NSManagedObject
        cell.DetailCell?.text = data.valueForKey("note") as? String
        cell.SaveImage?.image = UIImage(named: "1")
        if cell.SaveImage?.image == nil{
          cell.SaveImage?.image = UIImage(named: "1")
            
        }
        print(data)
         cell.SaveImage!.image = UIImage(data: data.image!)
         return cell
    }
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        context.deleteObject(Datas[indexPath.row]as NSManagedObject)
        Datas.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        
        
        var error:NSError? = nil
        do {
            try context.save()
        } catch let error1 as NSError {
            error = error1
            abort()
        }
    }

    

    
}
