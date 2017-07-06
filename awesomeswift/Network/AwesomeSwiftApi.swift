//
//  AwesomeSwiftApi.swift
//  awesomeswift
//
//  Created by Matteo Crippa on 11/06/2017.
//  Copyright © 2017 Boostcode. All rights reserved.
//

import Foundation

class AwesomeSwiftApi: AwesomeApi {
  class func getData() -> Data? {
    do {
      let data = try Data(contentsOf: URL(string: "https://raw.githubusercontent.com/matteocrippa/awesome-swift/master/database.json")!)
      return data
    } catch (let error) {
      print("🙅 \(error)")
      return nil
    }
  }

}
