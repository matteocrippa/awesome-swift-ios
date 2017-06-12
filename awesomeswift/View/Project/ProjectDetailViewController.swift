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
  
  var project: Project?
    
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // if project has a value
    if let project = project {
      // load webview
      webView.loadRequest(URLRequest(url: project.homepage))
    }
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
}

