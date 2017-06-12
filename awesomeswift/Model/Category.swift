//
//  Category.swift
//  awesomeswift
//
//  Created by Matteo Crippa on 11/06/2017.
//  Copyright © 2017 Boostcode. All rights reserved.
//

import Foundation

struct Category: Codable {
  var title: String
  var id: String
  var parent: String? // first level categories has not parent
  var description: String?
  
  // improve datamodel with sub categories
  var subCategories: [Category]? {
    return MemoryDb.shared.data?.categories.filter({ category -> Bool in
      return category.parent == id
    })
  }
  
  // improve data model with list of related projects
  var projects: [Project]? {
    return MemoryDb.shared.data?.projects.filter({ project -> Bool in
      return project.category == id
    })
  }
}
