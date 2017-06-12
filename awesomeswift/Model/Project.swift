//
//  Project.swift
//  awesomeswift
//
//  Created by Matteo Crippa on 11/06/2017.
//  Copyright © 2017 Boostcode. All rights reserved.
//

import Foundation

struct Project: Codable {
  let title: String
  let category: String
  let description: String
  let homepage: URL
  let tags: [String]?
}
