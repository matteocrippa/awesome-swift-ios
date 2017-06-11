//
//  Project.swift
//  awesomeswift
//
//  Created by Matteo Crippa on 11/06/2017.
//  Copyright © 2017 Boostcode. All rights reserved.
//

import Foundation

struct Project: Codable {
  var title: String
  var category: String
  var description: String
  var homepage: String
  var tags: [String]?
}
