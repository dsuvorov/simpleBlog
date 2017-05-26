//
//  PostRecords+CoreDataClass.swift
//  simpleBlog
//
//  Created by Dmitry Suvorov on 24/05/17.
//  Copyright © 2017 ip-suvorov. All rights reserved.
//

import Foundation
import CoreData

@objc(PostRecords)
public class PostRecords: NSManagedObject {
    convenience init() {
        // Описание сущности
        let entity = NSEntityDescription.entity(forEntityName: "PostRecords", in: MyDB.sharedInstance.managedObjectContext)
        
        // Создание нового объекта
        self.init(entity: entity!, insertInto: MyDB.sharedInstance.managedObjectContext)
    }
}
