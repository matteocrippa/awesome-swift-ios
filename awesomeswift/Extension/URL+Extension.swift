//
//  URL+Extensions.swift
//  awesomeswift
//
//  Created by Matteo Crippa on 27/06/2017.
//  Copyright © 2017 Boostcode. All rights reserved.
//

import Foundation

extension URL {
  var readmeURL: URL? {
    return URL(string: self.absoluteString.replacingOccurrences(of: "https://github.com/", with: "https://raw.githubusercontent.com/").appending("/master/README.md"))
  }
}
