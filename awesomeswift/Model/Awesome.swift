//
//  Awesome.swift
//  awesomeswift
//
//  Created by Matteo Crippa on 11/06/2017.
//  Copyright © 2017 Boostcode. All rights reserved.
//

import Foundation

struct Awesome: Codable {
  var title: String
  var header: String
  var header_contributing: String
  var ios_app_link: String
  var categories: [Category]
  var projects: [Project]
}
