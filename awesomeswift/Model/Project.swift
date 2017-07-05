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
  
  /// Check if project is favorite locally (synch via iCloud)
  var isFavorite: Bool {
    get {
      return UserDefaults.standard.bool(forKey: homepage.absoluteString)
    }
    set {
      UserDefaults.standard.set(newValue, forKey: homepage.absoluteString)
      UserDefaults.standard.synchronize()
    }
    
  }
}
