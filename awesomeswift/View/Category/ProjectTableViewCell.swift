//
//  ProjectTableViewCell.swift
//  awesomeswift
//
//  Created by Matteo Crippa on 12/06/2017.
//  Copyright © 2017 Boostcode. All rights reserved.
//

import UIKit

class ProjectTableViewCell: UITableViewCell {

  // public
  var project: Project?

  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }

  func setup(with project: Project) {
    // store project
    self.project = project

    // set UI
    let starString = NSAttributedString(
      string: "\(project.isFavorite ? "★" : "") ",
      attributes: [
        NSAttributedStringKey.foregroundColor: UIColor.awesomePink
      ]
    )
    let titleString = NSAttributedString(string: "\(project.title)")

    let completeString = NSMutableAttributedString()
    completeString.append(starString)
    completeString.append(titleString)

    textLabel?.attributedText = completeString

  }

}
