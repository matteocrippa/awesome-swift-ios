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
  
  fileprivate var favoriteButton = UIButton(type: .plain)
  fileprivate var favoriteButtonItem: UIBarButtonItem {
    favoriteButton.setTitle("☆", for: .normal)
    favoriteButton.setTitle("✭", for: .selected)
    favoriteButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 28)
    favoriteButton.tintColor = .awesomePink
    favoriteButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
    favoriteButton.addTarget(self, action: #selector(ProjectDetailViewController.favoriteToggle(_:)), for: .touchUpInside)
    return UIBarButtonItem(customView: favoriteButton)
  }
  fileprivate var openButtonItem: UIBarButtonItem {
    let btn = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(ProjectDetailViewController.openProject))
    btn.tintColor = .awesomePink
    return btn
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
    navigationItem.rightBarButtonItems = [favoriteButtonItem, openButtonItem]
    
    
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
  
  @objc func openProject() {
    if let project = project {
      
      // set up activity view controller
      let textToShare = [ project.homepage ]
      let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
      activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
      
      // present the view controller
      present(activityViewController, animated: true, completion: nil)
      
    }
  }
  
}

