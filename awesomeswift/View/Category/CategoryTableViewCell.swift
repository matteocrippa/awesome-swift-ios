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
    textLabel?.text = "\(category.title)"
    
    // if we have a subcat
    if let subCats = category.subCategories, subCats.count > 0 {
      // append to label
      textLabel?.text = textLabel?.text?.appending(" ▼")
    }
    
    // if we have projects
    if let projects = category.projects, projects.count > 0 {
      // append to label
      textLabel?.text = textLabel?.text?.appending(" (\(projects.count))")
    }
  }
  
}
