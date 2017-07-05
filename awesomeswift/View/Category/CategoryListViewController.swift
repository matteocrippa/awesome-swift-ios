//
//  CategoryListViewController.swift
//  awesomeswift
//
//  Created by Matteo Crippa on 11/06/2017.
//  Copyright © 2017 Boostcode. All rights reserved.
//

import UIKit
import Exteptional

class CategoryListViewController: UIViewController {
  
  /// public
  @IBOutlet weak var table: UITableView!
  var parentCategory: String?
  
  /// private
  fileprivate var results = Results([], []) {
    didSet {
      table.reloadData()
    }
  }
  fileprivate var filteredResults = Results([], [])
  
  fileprivate let searchController = UISearchController(searchResultsController: nil)
  fileprivate lazy var refreshControl: UIRefreshControl = {
    let refreshControl = UIRefreshControl()
    refreshControl.tintColor = .awesomePink
    refreshControl.addTarget(self, action: #selector(CategoryListViewController.getRemoteData), for: .valueChanged)
    return refreshControl
  }()
  fileprivate var isSearchActive: Bool {
    return filteredResults.0.count > 0 || filteredResults.1.count > 0
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // set searchController
    searchController.searchResultsUpdater = self
    searchController.searchBar.placeholder = "Filter"
    searchController.searchBar.tintColor = .awesomePink
    
    // if we are at root level
    if parentCategory == nil {
      // set title
      #if AWESOMESWIFT
        title = "Awesome Swift"
      #else
        title = "Awesome Open Source iOS Apps"
      #endif
      
      // add refresh control
      table.refreshControl = refreshControl
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
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    // if parent category has not been set
    if parentCategory == nil {
      // force get data by remote
      getRemoteData()
    } else {
      // get local data
      results = getResults(for: parentCategory)
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
      // get all results for root
      results = getResults(for: nil)
      //print("👨‍💻 decoded:", decoded)
    } catch (let error) {
      print("🙅 \(error)")
    }
  }
  
  @objc fileprivate func getRemoteData() {
    
    // start refreshing
    refreshControl.beginRefreshing()
    
    // show latest update
    let lastUpdate = "last update: \(MemoryDb.shared.lastUpdate.toString(dateFormat: "dd/MM/yyyy @ HH:mm"))"
    refreshControl.attributedTitle = NSAttributedString(string: lastUpdate)
    
    // retrieve data from remote
    #if AWESOMESWIFT
      if let data = AwesomeSwiftApi.getData() {
        // parse json
        parseJson(from: data)
        
        // stop refreshing
        refreshControl.endRefreshing()
      }
    #else
      if let data = AwesomeOpenSourceiOSAppApi.getData() {
        // parse json
        parseJson(from: data)
        
        // stop refreshing
        refreshControl.endRefreshing()
      }
    #endif
  }
}

// MARK: - Database (Memory)
extension CategoryListViewController {
  
  func getResults(for parent: String?) -> Results {
    if let data = MemoryDb.shared.data {
      // filter only categories that have parent
      var cats = data.categories.filter({ category -> Bool in
        return category.parent == parent
      })
      
      // sort by title A-Z
      cats = cats.sorted(by: { (a, b) -> Bool in
        return a.title.lowercased() < b.title.lowercased()
      })
      
      // filter only projects that have parent
      var projects = data.projects.filter({ proj -> Bool in
        return proj.category == parent
      })
      
      // sort by title A-Z
      projects = projects.sorted(by: { (a, b) -> Bool in
        return a.title.lowercased() < b.title.lowercased()
      })
      
      return Results(cats, projects)
    }
    return Results([], [])
  }
  
}


// MARK: - UISearchBar Delegate
extension CategoryListViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    
    // check if search is active
    if searchController.isActive && searchController.searchBar.text != nil {
      
      // force clear the results first
      filteredResults = Results([], [])
      
      // get current search text and proceed only if has at least a character inside
      if let searchText = searchController.searchBar.text, searchText.count > 0 {
        // get all the cats that match the title
        let cats = MemoryDb.shared.data?.categories.filter({ cat -> Bool in
          return cat.title.lowercased().contains(searchText.lowercased())
        })
        
        // get all projects that have the text inside in the title
        let projs = MemoryDb.shared.data?.projects.filter({ proj -> Bool in
          return proj.title.lowercased().contains(searchText.lowercased())
        })
        
        // populate filtered results
        filteredResults = Results(cats ?? [], projs ?? [])
      }
      
      // reload table
      table.reloadData()
    }
    
  }
}

// MARK: - UITableView Data Source
extension CategoryListViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    // check if we have any project
    return (isSearchActive && filteredResults.1.count == 0) ? 1 : 2
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    switch section {
    case 0:
      return isSearchActive ? filteredResults.0.count : results.0.count
    case 1:
      return isSearchActive ? filteredResults.1.count : results.1.count
    default:
      return 0
    }
    
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    // filter according section
    switch indexPath.section {
    case 0:
      // get category
      let category = isSearchActive ? filteredResults.0[indexPath.row] : results.0[indexPath.row]
      // generate cell
      return prepareCategoryCell(with: category, at: indexPath)
    case 1:
      // get project
      let project = isSearchActive ? filteredResults.1[indexPath.row] : results.1[indexPath.row]
      return prepareProjectCell(with: project, at: indexPath)
      
    default:
      return UITableViewCell()
    }
    
  }
  
  /// Category cell generator
  fileprivate func prepareCategoryCell(with category: Category, at indexPath: IndexPath) -> CategoryTableViewCell {
    if let cell = table.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as? CategoryTableViewCell {
      // setup category with proper method
      cell.setup(with: category)
      // return cell
      return cell
    }
    return CategoryTableViewCell()
  }
  
  /// Project cell generator
  fileprivate func prepareProjectCell(with project: Project, at indexPath: IndexPath) -> ProjectTableViewCell {
    if let cell = table.dequeueReusableCell(withIdentifier: "projectCell", for: indexPath) as? ProjectTableViewCell {
      // setup project with proper method
      cell.setup(with: project)
      // return cell
      return cell
    }
    return ProjectTableViewCell()
    
  }
}

// MARK: - UITableView Deleage
extension CategoryListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    switch indexPath.section {
    case 0:
      let category = results.0[indexPath.row]
      // get category view controller
      if let vc = UIStoryboard(name: "Category", bundle: nil).instantiateViewController(withIdentifier: "CategoryList") as? CategoryListViewController {
        // pass paramters for customizarion
        // set title of the view according current category title
        vc.title = category.title
        // pass current category id for filtering
        vc.parentCategory = category.id
        // push the vc
        navigationController?.pushViewController(vc, animated: true)
      }
    case 1:
      let project = results.1[indexPath.row]
      
      if let vc = UIStoryboard(name: "Project", bundle: nil).instantiateInitialViewController() as? ProjectDetailViewController {
        // set title of view
        vc.title = project.title
        // pass project info
        vc.project = project
        // push the vc
        navigationController?.pushViewController(vc, animated: true)
      }
    default:
      break
    }
    
    // force deselect row
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
