//
//  CategoryTableViewCell.swift
//  awesomeswift
//
//  Created by Matteo Crippa on 12/06/2017.
//  Copyright © 2017 Boostcode. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
  
  var category: Category?
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  func setup(with category: Category) {
    // store category
    self.category = category
    
    // set UI
    textLabel?.text = category.title
  }
  
}
