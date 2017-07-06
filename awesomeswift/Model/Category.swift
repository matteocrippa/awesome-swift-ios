//
//  Category.swift
//  awesomeswift
//
//  Created by Matteo Crippa on 11/06/2017.
//  Copyright © 2017 Boostcode. All rights reserved.
//

import Foundation

struct Category: Codable {
  let title: String
  let id: String
  let parent: String? // first level categories has not parent
  let description: String?

  // improved datamodel with sub categories
  var subCategories: [Category]? {
    return MemoryDb.shared.data?.categories.filter({ category -> Bool in
      return category.parent == id
    })
  }

  // improve data model with list of related projects
  var projects: [Project]? {
    return MemoryDb.shared.data?.projects.filter({ project -> Bool in
      return project.categoryIds.contains(id)
    })
  }
}
