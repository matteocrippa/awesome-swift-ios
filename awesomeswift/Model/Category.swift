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
}
