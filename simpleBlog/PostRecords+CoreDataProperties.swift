//
//  PostRecords+CoreDataProperties.swift
//  simpleBlog
//
//  Created by Dmitry Suvorov on 24/05/17.
//  Copyright © 2017 ip-suvorov. All rights reserved.
//

import Foundation
import CoreData


extension PostRecords {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PostRecords> {
        return NSFetchRequest<PostRecords>(entityName: "PostRecords");
    }

    @NSManaged public var date: Date?
    @NSManaged public var id: Int16
    @NSManaged public var is_synched: Bool
    @NSManaged public var name: String?
    @NSManaged public var body: String?
    @NSManaged public var user_pic_url: String?

}
