//
//  TableViewItem.swift
//  simpleBlog
//
//  Created by Dmitry Suvorov on 07/06/17.
//  Copyright © 2017 ip-suvorov. All rights reserved.
//
import Foundation

struct TableViewItem
{
    /**
     *  Attributes here
     */
    var id: Int
    var date: Date
    var name: String
    var body: String?
    var userPicUrl: String?
    var isSynched: Bool = false
    var objectIdURI: URL
    
    init(id: Int, date: Date, name: String, body: String?, userPicUrl: String?) { // initialize with only these props
        self.id = id
        self.date = date
        self.name = name
        self.body = body
        self.userPicUrl = userPicUrl
    }
}
