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
    convenience init(MOC: NSManagedObjectContext) {
        // Описание сущности
        let entity = NSEntityDescription.entity(forEntityName: "PostRecords", in: MOC)
        
        // Создание нового объекта
        self.init(entity: entity!, insertInto: MOC)
    }
}
