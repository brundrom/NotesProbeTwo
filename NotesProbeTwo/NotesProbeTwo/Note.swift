//
//  Note.swift
//  NotesApplication
//
//  Created by pga on 25.04.2022.
//  Copyright © 2022 pga. All rights reserved.
//

import CoreData

@objc(Note)
class Note: NSManagedObject
{
    @NSManaged var id: NSNumber!
    @NSManaged var title: String!
    @NSManaged var desc: String!
    @NSManaged var deletedDate: Date?
}
