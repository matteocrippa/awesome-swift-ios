//
//  CategoryListViewController.swift
//  awesomeswift
//
//  Created by Matteo Crippa on 11/06/2017.
//  Copyright © 2017 Boostcode. All rights reserved.
//

import UIKit

class CategoryListViewController: UIViewController {
  
  @IBOutlet weak var table: UITableView!
  
  fileprivate var searchController = UISearchController()
  
  fileprivate var categoriesList = [Category]() {
    // on update
    didSet {
      // reload table
      table.reloadData()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // set title
    title = "Awesome Swift"
    
    // set searchController
    searchController.delegate = self
    searchController.searchBar.placeholder = "Filter Categories"
    
    // add search to new navigation
    navigationItem.searchController = searchController
    
    // force reload data
    getData()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
  }
  
}

// MARK: - Networking
extension CategoryListViewController {
  
  fileprivate func parseJson(from data: Data) {
    do {
      let decoded = try JSONDecoder().decode(Awesome.self, from: data)
      print("👨‍💻 decoded:", decoded)
    } catch (let error) {
      print("🙅 \(error)")
    }
  }
  
  fileprivate func getData() {
    
    if let data = AwesomeSwiftApi.getData() {
      parseJson(from: data)
    }
    
  }
}

// MARK: - UISearchController Delegate
extension CategoryListViewController: UISearchControllerDelegate {
  
}

// MARK: - UITableView Data Source
extension CategoryListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return UITableViewCell()
  }
  
}
