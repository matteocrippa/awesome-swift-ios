//
//  MemoryDb.swift
//  awesomeswift
//
//  Created by Matteo Crippa on 11/06/2017.
//  Copyright © 2017 Boostcode. All rights reserved.
//

import Foundation

class MemoryDb {
  /// Shared instance
  open static var shared = MemoryDb()
  private init() {}

  /// Contains data
  var data: Awesome? {
    didSet {
      lastUpdate = Date()
    }
  }

  /// Contains last update date
  var lastUpdate = Date()
}
