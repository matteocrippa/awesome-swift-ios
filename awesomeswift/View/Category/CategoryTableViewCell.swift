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

    var subCatString = NSMutableAttributedString()
    var countString = NSMutableAttributedString()

    // if we have a subcat
    if let subCats = category.subCategories, subCats.count > 0 {
      // append to label
      subCatString = NSMutableAttributedString(
        string: " ▼",
        attributes: [
          NSAttributedStringKey.foregroundColor: UIColor.awesomePink
        ]
      )
    }

      // if we have projects
    else if let projects = category.projects, projects.count > 0 {
      // append to label
      countString = NSMutableAttributedString(
        string: " (\(projects.count))",
        attributes: [
          NSAttributedStringKey.font: UIFont.systemFont(ofSize: 11)
        ]
      )
    }

    let completeString = NSMutableAttributedString()
    completeString.append(NSAttributedString(string: "\(category.title)"))
    completeString.append(subCatString)
    completeString.append(countString)

    // set UI
    textLabel?.attributedText = completeString

  }

}
