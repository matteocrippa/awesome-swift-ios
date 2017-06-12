//
//  RepositoryDetailViewController.swift
//  awesomeswift
//
//  Created by Matteo Crippa on 11/06/2017.
//  Copyright © 2017 Boostcode. All rights reserved.
//

import UIKit

class ProjectDetailViewController: UIViewController {
  
  @IBOutlet var webView: UIWebView!
  
  fileprivate var favoriteButton = UIButton(type: .custom)
  fileprivate var favoriteButtonItem: UIBarButtonItem {
    let emptyImage = #imageLiteral(resourceName: "Star").withRenderingMode(.alwaysTemplate)
    let fullImage = #imageLiteral(resourceName: "StarFull").withRenderingMode(.alwaysTemplate)
    favoriteButton.setImage(emptyImage, for: .normal)
    favoriteButton.setImage(fullImage, for: .selected)
    favoriteButton.tintColor = .awesomePink
    favoriteButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
    favoriteButton.addTarget(self, action: #selector(ProjectDetailViewController.favoriteToggle(_:)), for: .touchUpInside)
    return UIBarButtonItem(customView: favoriteButton)
  }
  
  var project: Project?
    
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // set large title
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationController?.navigationBar.titleTextAttributes = [
      NSAttributedStringKey.foregroundColor.rawValue: UIColor.awesomePink
    ]
    navigationController?.navigationBar.tintColor = .awesomePink
    
    navigationItem.largeTitleDisplayMode = .always
    
    // add bar button
    navigationItem.rightBarButtonItem = favoriteButtonItem
    
    
    // if project has a value
    if let project = project {
      // load webview
      webView.loadRequest(URLRequest(url: project.homepage))
      
      // set if favorite
      favoriteButton.isSelected = project.isFavorite
    }
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  @objc func favoriteToggle(_ sender: UIButton) {
    if var project = project {
      project.isFavorite = !project.isFavorite
      sender.isSelected = project.isFavorite
    }
  }
  
}

