//
//  AwesomeApi.swift
//  awesomeswift
//
//  Created by Matteo Crippa on 05/07/2017.
//  Copyright © 2017 Boostcode. All rights reserved.
//

import Foundation

class AwesomeApi {
  class func getProjectReadme(url: URL) -> String? {
    do {
      let data = try Data(contentsOf: url.readmeURL!)
      return String(data: data, encoding: .utf8)
    } catch (let error) {
      print("🙅 \(error)")
      return nil
    }
  }
}
