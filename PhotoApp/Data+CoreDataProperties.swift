//
//  Data+CoreDataProperties.swift
//  PhotoApp
//
//  Created by Tcacenco Daniel on 11/22/15.
//  Copyright © 2015 Inga. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Data {

    @NSManaged var image: NSData?
    @NSManaged var lat: NSNumber?
    @NSManaged var long: NSNumber?
    @NSManaged var note: String?
    @NSManaged var text: String?

}
