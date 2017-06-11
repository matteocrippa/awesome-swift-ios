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
  
  fileprivate let searchController = UISearchController(searchResultsController: nil)
  fileprivate lazy var refreshControl: UIRefreshControl = {
    let refreshControl = UIRefreshControl()
    refreshControl.tintColor = .white
    refreshControl.addTarget(self, action: #selector(CategoryListViewController.getRemoteData), for: .valueChanged)
    return refreshControl
  }()
  
  /// Returns the list of the current parent directories
  fileprivate var parentCategories: [Category] {
    if let data = MemoryDb.shared.data {
      
      //filter only categories that are parent (parent == nil)
      let cats = data.categories.filter({ category -> Bool in
        return category.parent == nil
      })
      
      // sort by title A-Z
      return  cats.sorted(by: { (a, b) -> Bool in
        return a.title < b.title
      })
    }
    // if none return empty array
    return [Category]()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // set title
    title = "Awesome Swift"
    
    // set searchController
    searchController.delegate = self
    searchController.searchBar.placeholder = "Filter categories"
    
    // add refresh control
    table.addSubview(refreshControl)
    
    // set large title
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationController?.navigationBar.titleTextAttributes = [
      NSAttributedStringKey.foregroundColor.rawValue: UIColor.awesomePink
    ]
    navigationController?.navigationBar.tintColor = .awesomePink
    
    // set extra stuff for navigation bar
    navigationItem.searchController = searchController
    navigationItem.hidesSearchBarWhenScrolling = false
    navigationItem.hidesBackButton = true
    
    // force reload data
    getRemoteData()
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
      MemoryDb.shared.data = decoded
      // force reload table, I would prefer the didSet approach, but this works fine too
      table.reloadData()
      print("👨‍💻 decoded:", decoded)
    } catch (let error) {
      print("🙅 \(error)")
    }
  }
  
  @objc fileprivate func getRemoteData() {
    
    // start refreshing
    refreshControl.beginRefreshing()
    
    // show latest update
    refreshControl.attributedTitle = NSAttributedString(string: MemoryDb.shared.lastUpdate.description)
    
    // retrieve data from remote
    if let data = AwesomeSwiftApi.getData() {
      // parse json
      parseJson(from: data)
      
      // stop refreshing
      refreshControl.endRefreshing()
    }
  }
}

// MARK: - UISearchController Delegate
extension CategoryListViewController: UISearchControllerDelegate {
  
}

// MARK: - UITableView Data Source
extension CategoryListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return parentCategories.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
    cell.textLabel?.text = parentCategories[indexPath.row].title
    return cell
  }
  
}
