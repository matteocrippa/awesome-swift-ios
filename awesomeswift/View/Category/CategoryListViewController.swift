//
//  CategoryListViewController.swift
//  awesomeswift
//
//  Created by Matteo Crippa on 11/06/2017.
//  Copyright © 2017 Boostcode. All rights reserved.
//

import UIKit

class CategoryListViewController: UIViewController {
  
  /// public
  @IBOutlet weak var table: UITableView!
  var parentCategory: String?
  
  /// private
  fileprivate var categories = [Category]() {
    didSet {
      table.reloadData()
    }
  }
  fileprivate let searchController = UISearchController(searchResultsController: nil)
  fileprivate lazy var refreshControl: UIRefreshControl = {
    let refreshControl = UIRefreshControl()
    refreshControl.tintColor = .white
    refreshControl.addTarget(self, action: #selector(CategoryListViewController.getRemoteData), for: .valueChanged)
    return refreshControl
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // set searchController
    searchController.delegate = self
    searchController.searchBar.placeholder = "Filter categories"
    
    // if we are at root
    if parentCategory == nil {
      // set title
      title = "Awesome Swift"
      
      // add refresh control
      table.addSubview(refreshControl)
    }
    
    // set large title
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationController?.navigationBar.titleTextAttributes = [
      NSAttributedStringKey.foregroundColor.rawValue: UIColor.awesomePink
    ]
    navigationController?.navigationBar.tintColor = .awesomePink
    
    // set extra stuff for navigation bar
    navigationItem.searchController = searchController
    navigationItem.hidesSearchBarWhenScrolling = false
    navigationItem.hidesBackButton = false
    navigationItem.largeTitleDisplayMode = .always
    
    // if parent category has not been set
    if parentCategory == nil {
      // force get data by remote
      getRemoteData()
    } else {
      // get local data
      categories = getCategories(with: parentCategory)
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
}

// MARK: - Networking
extension CategoryListViewController {
  
  fileprivate func parseJson(from data: Data) {
    do {
      let decoded = try JSONDecoder().decode(Awesome.self, from: data)
      MemoryDb.shared.data = decoded
      // get all categories for root
      categories = getCategories(with: nil)
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

// MARK: - Database (Memory)
extension CategoryListViewController {
  func getCategories(with parent: String?) -> [Category]{
    if let data = MemoryDb.shared.data {
      
      // filter only categories that are parent (parent == nil)
      let cats = data.categories.filter({ category -> Bool in
        return category.parent == parent
      })
      
      // sort by title A-Z
      return  cats.sorted(by: { (a, b) -> Bool in
        return a.title < b.title
      })
    }
    // if none return empty array
    return [Category]()
  }
}

// MARK: - UISearchController Delegate
extension CategoryListViewController: UISearchControllerDelegate {
  
}

// MARK: - UITableView Data Source
extension CategoryListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return categories.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryTableViewCell
    // setup category with proper method
    cell.setup(with: categories[indexPath.row])
    return cell
  }
  
}

// MARK: - UITableView Deleage
extension CategoryListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // check if we have subcategories
    if let subCategories = categories[indexPath.row].subCategories, subCategories.count > 0 {
      let vc = UIStoryboard(name: "Category", bundle: nil).instantiateViewController(withIdentifier: "CategoryList") as! CategoryListViewController
      vc.title = categories[indexPath.row].title
      vc.parentCategory = categories[indexPath.row].id
      navigationController?.pushViewController(vc, animated: true)
    } else { // otherwise show repos
      //performSegue(withIdentifier: "showProjects", sender: self)
    }
  }
}
