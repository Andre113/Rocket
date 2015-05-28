//
//  Levels.swift
//  Rocket
//
//  Created by Rafael  Hieda on 28/05/15.
//  Copyright (c) 2015 Andre Lucas Ota. All rights reserved.
//

import Foundation
import CoreData

class Levels: NSManagedObject {

    @NSManaged var status: NSNumber
    @NSManaged var stageName: String

}
