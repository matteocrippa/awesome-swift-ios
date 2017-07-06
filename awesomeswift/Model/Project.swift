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
  let categoryIds: [String]
  let description: String?
  let source: URL
  let tags: [String]?
  let license: String?
  let itunes: String?
  let dateAdded: String?
  let suggestedBy: String?
  let screenshots: [String]?

  /// Check if project is favorite locally (sync via iCloud)
  var isFavorite: Bool {
    get {
      return UserDefaults.standard.bool(forKey: source.absoluteString)
    }
    set {
      UserDefaults.standard.set(newValue, forKey: source.absoluteString)
      UserDefaults.standard.synchronize()
    }

  }

  // fix naming conventions from JSON
  // date_added
  // suggested_by
  // category-ids
  enum CodingKeys: String, CodingKey {

    case title
    case description
    case source
    case tags
    case license
    case itunes
    case screenshots

    case dateAdded = "date_added"
    case suggestedBy = "suggested_by"
    case categoryIds = "category-ids"
  }
}

// MARK: - Decoding manually
/*extension Project: Decodable {
  init(from decoder: Decoder) throws {
  }
}*/
