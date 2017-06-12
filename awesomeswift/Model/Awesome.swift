//
//  Awesome.swift
//  awesomeswift
//
//  Created by Matteo Crippa on 11/06/2017.
//  Copyright © 2017 Boostcode. All rights reserved.
//

import Foundation

struct Awesome: Codable {
  let title: String
  let header: String
  let header_contributing: String
  let ios_app_link: String
  let categories: [Category]
  let projects: [Project]
}
